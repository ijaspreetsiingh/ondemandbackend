<?php

namespace Modules\ChattingModule\Http\Controllers\Api\V1\Customer;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Modules\ChattingModule\Entities\ChannelConversation;
use Modules\ChattingModule\Entities\ChannelList;
use Modules\ChattingModule\Entities\ChannelUser;
use Modules\ChattingModule\Entities\ConversationFile;
use Modules\ChattingModule\Traits\ChattingTrait;
use Modules\ProviderManagement\Entities\Provider;
use Modules\UserManagement\Entities\Serviceman;
use Modules\UserManagement\Entities\User;
use Ramsey\Uuid\Nonstandard\Uuid;
use function file_uploader;
use function response;
use function response_formatter;

class ChattingController extends Controller
{
    protected ChannelList $channelList;
    protected ChannelUser $channelUser;
    protected ChannelConversation $channelConversation;
    protected ConversationFile $conversationFile;

    use ChattingTrait;

    public function __construct(ChannelList $channelList, ChannelUser $channelUser, ChannelConversation $channelConversation, ConversationFile $conversationFile)
    {
        $this->channelList = $channelList;
        $this->channelUser = $channelUser;
        $this->channelConversation = $channelConversation;
        $this->conversationFile = $conversationFile;
    }

    /**
     * Display a listing of the resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function channelList(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000',
            'type' => 'nullable|in:provider,serviceman',
            'search' => 'nullable'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        //admin channel
        $channel = $this->createNewChannel(
            fromUser: $request->user()->id,
            toUser: getSuperAdminId(),
            referenceId: '',
            referenceType: 'support',
        );

        $adminChannel = $this->channelList
            ->withCount('channelUsers')
            ->with([
                'channelLastConversation',
                'channelUsers.user',
            ])
            ->where('id', $channel->id)
            ->first();

        $this->formatConversation($adminChannel);

        $channelList = $this->channelList
            ->withCount(['channelUsers'])
            ->with(['channelUsers.user.provider'])
            ->whereHas('channelUsers', function ($query) use ($request) {
                $query->where(['user_id' => $request->user()->id]);
            })
            ->when($request->has('search'), function ($query) use ($request) {
                $query->searchByUser(['provider', 'serviceman'], explode(' ', $request->input('search')), ['first_name', 'last_name']);
            })
            ->when(!$request->has('search'), function ($query) use ($request) {
                $query->filterByType($request['type']);
            })
            ->where('id', '!=', $adminChannel->id)
            ->orderBy('updated_at', 'DESC')
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])
            ->withPath('');

        $this->formatConversations($channelList);

        $channelList->getCollection()->transform(function ($channel) {
            foreach ($channel->channelUsers as $channelUser) {
                if (isset($channelUser->user->provider)) {
                    $providerId = $channelUser->user->provider->id;
                    $channelUser->user->provider->chatEligibility = chatEligibility($providerId);
                    $channelUser->user->provider->callingEnabled = (bool)($channelUser->user->provider->calling_enabled ?? false);
                }
            }
            return $channel;
        });

        return response()->json(response_formatter(DEFAULT_200, [
            'adminChannel' => $adminChannel,
            'channelList' => $channelList,
        ]), 200);
    }

    /**
     * Display a listing of the resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function channelListSearch(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000',
            'search' => 'required'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $chatList = $this->channelList->withCount(['channelUsers'])
            ->with(['channelUsers.user.provider'])
            ->whereHas('channelUsers', function ($query) use ($request) {
                $query->where(['user_id' => $request->user()->id]);
            })
            ->searchByUser(['provider', 'serviceman'], explode(' ', $request->input('search')), ['first_name', 'last_name'])
            ->orderBy('updated_at', 'DESC')
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        $chatList->each(function ($channel) {
            $lastConversation = $channel?->channelLastConversation;
            $lastFile = $lastConversation?->conversationLastFile?->first();
            $channel->last_sent_message = $lastConversation?->message;
            $channel->last_sent_attachment_type = $lastFile?->file_type;
            $channel->last_sent_files_count = (int)$lastConversation?->conversationLastFile?->count();
            $channel->last_message_sent_user = $lastConversation?->user->first_name . ' ' . $lastConversation?->user->last_name;
            unset($channel->channelLastConversation);
        });

        return response()->json(response_formatter(DEFAULT_200, $chatList), 200);
    }


    /**
     * Display a listing of the resource.
     * @param Request $request
     * @return JsonResponse
     */
    public function referencedChannelList(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'limit' => 'required|numeric|min:1|max:200',
            'offset' => 'required|numeric|min:1|max:100000',
            'reference_id' => 'required',
            'reference_type' => 'required|in:booking_id',
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $chatList = $this->channelList->withCount(['channelUsers'])->with(['channelUsers.user'])
            ->where(['reference_id' => $request['reference_id'], 'reference_type' => $request['reference_type']])
            ->whereHas('channelUsers', function ($query) use ($request) {
                $query->where(['user_id' => $request->user()->id]);
            })->orderBy('updated_at', 'DESC')
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        return response()->json(response_formatter(DEFAULT_200, $chatList), 200);
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return JsonResponse
     */
    public function createChannel(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'reference_id' => '',
            'reference_type' => 'in:booking_id',
            // `to_user` user id, provider id ya serviceman id — teeno accept karte hain
            // aur niche real login user me resolve karte hain. Pehle yahan `uuid`
            // rule tha, isliye purane/company provider ke non-standard ids par
            // chat 400 "The to user must be a valid UUID" de deta tha.
            'to_user' => 'required|string|max:64'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $toUserId = $this->resolveChatUserId($request['to_user']);

        if (!$toUserId) {
            return response()->json(response_formatter(DEFAULT_404, null, [[
                'error_code' => 'to_user',
                'message' => translate('The selected contact is not available for chat'),
            ]]), 404);
        }

        if ((string)$toUserId === (string)$request->user()->id) {
            return response()->json(response_formatter(DEFAULT_400, null, [[
                'error_code' => 'to_user',
                'message' => translate('You can not start a conversation with yourself'),
            ]]), 400);
        }

        $channelIds = $this->channelUser->where(['user_id' => $request->user()->id])->pluck('channel_id')->toArray();
        $findChannel = $this->channelList->whereIn('id', $channelIds)->whereHas('channelUsers', function ($query) use ($toUserId) {
            $query->where(['user_id' => $toUserId]);
        })->latest()->first();

        if (!isset($findChannel)) {
            $channel = $this->channelList;
            $channel->reference_id = $request['reference_id'] ?? null;
            $channel->reference_type = $request['reference_type'] ?? null;
            $channel->save();

            $this->channelUser->insert([
                [
                    'id' => Uuid::uuid4(),
                    'channel_id' => $channel->id,
                    'user_id' => $request->user()->id,
                    'created_at' => now(),
                    'updated_at' => now()
                ],
                [
                    'id' => Uuid::uuid4(),
                    'channel_id' => $channel->id,
                    'user_id' => $toUserId,
                    'created_at' => now(),
                    'updated_at' => now()
                ]
            ]);
            return response()->json(response_formatter(DEFAULT_STORE_200, $channel), 200);
        }

        return response()->json(response_formatter(DEFAULT_200, $findChannel), 200);
    }

    /**
     * Chat recipient ko real login user me resolve karo.
     *
     * App builds `to_user` me user id, provider id ya serviceman id bhej sakte
     * hain; kuch purane records ka uuid bina dash (32 hex) ya braces ke bhi ho
     * sakta hai. Sabko normalize karke users.id return karte hain, warna null.
     */
    private function resolveChatUserId($identifier): ?string
    {
        foreach ($this->chatIdentifierCandidates($identifier) as $candidate) {
            $userId = User::where('id', $candidate)->value('id');
            if ($userId) {
                return (string)$userId;
            }

            $providerUserId = Provider::where('id', $candidate)->value('user_id');
            if ($providerUserId && User::where('id', $providerUserId)->exists()) {
                return (string)$providerUserId;
            }

            $servicemanUserId = Serviceman::where('id', $candidate)->value('user_id');
            if ($servicemanUserId && User::where('id', $servicemanUserId)->exists()) {
                return (string)$servicemanUserId;
            }
        }

        return null;
    }

    /**
     * Diye gaye identifier ke possible uuid forms (trim / braces / bina dash).
     */
    private function chatIdentifierCandidates($identifier): array
    {
        $identifier = is_string($identifier) ? urldecode($identifier) : '';
        $identifier = trim($identifier, "{}[] \t\n\r\0\x0B");

        if ($identifier === '' || strtolower($identifier) === 'null' || $identifier === '0') {
            return [];
        }

        $candidates = [$identifier];

        // 32 hex chars = uuid bina dashes ke
        if (preg_match('/^[0-9a-fA-F]{32}$/', $identifier)) {
            $candidates[] = strtolower(preg_replace('/^(.{8})(.{4})(.{4})(.{4})(.{12})$/', '$1-$2-$3-$4-$5', $identifier));
        }

        return array_values(array_unique($candidates));
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return JsonResponse
     */
    public function sendMessage(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'message' => '',
            'channel_id' => 'required|uuid',
            'files' => is_null($request['message']) ? 'required|array' : 'array',
            'files.*' => 'max:'. uploadMaxFileSizeInKB('file') .'|mimes:' . implode(',', array_column(FILE_TYPE, 'key')),
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        DB::transaction(function () use ($request) {
            $this->channelList->where('id', $request['channel_id'])->update([
                'updated_at' => now()
            ]);
            $this->channelUser->where('channel_id', $request['channel_id'])->where('user_id', '!=', $request->user()->id)
                ->update([
                    'is_read' => 0
                ]);

            $channelConversation = $this->channelConversation;
            $channelConversation->channel_id = $request->channel_id;
            $channelConversation->message = $request['message'];
            $channelConversation->user_id = $request->user()->id;
            $channelConversation->save();

            if ($request->has('files')) {
                foreach ($request->file('files') as $file) {
                    $extension = $file->getClientOriginalExtension();
                    $originalName = $file->getClientOriginalName();

                    $this->conversationFile->create([
                        'conversation_id' => $channelConversation->id,
                        'original_file_name' => $originalName,
                        'stored_file_name' => file_uploader('conversation/', $extension, $file),
                        'file_type' => $extension,
                    ]);
                }
            }
        });

        return response()->json(response_formatter(DEFAULT_STORE_200), 200);
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return JsonResponse
     */
    public function conversation(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'channel_id' => 'required|uuid'
        ]);

        if ($validator->fails()) {
            return response()->json(response_formatter(DEFAULT_400, null, error_processor($validator)), 400);
        }

        $this->channelUser->where('channel_id', $request['channel_id'])->where('user_id', $request->user()->id)
            ->update([
                'is_read' => 1
            ]);

        $conversation = $this->channelConversation->where(['channel_id' => $request['channel_id']])
            ->with(['user', 'conversationFiles'])->whereHas('channel.channelUsers', function ($query) use ($request) {
                $query->where(['user_id' => $request->user()->id]);
            })->latest()
            ->paginate($request['limit'], ['*'], 'offset', $request['offset'])->withPath('');

        return response()->json(response_formatter(DEFAULT_STORE_200, $conversation), 200);
    }
}
