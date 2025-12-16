using Google.Protobuf;
using Google.Protobuf.Protocol;
using ServerCore;


class PacketHandler
{
    public static void S_ConnectHandler(PacketSession session, IMessage packet)
    {
        S_Connect chatPacket = packet as S_Connect;
        PlayerInfo playerInfo = new PlayerInfo()
        {
            PlayerId = 1,
            Name = "PlayerOne",
            PosX = 100,
            PosY = 200
        };
        chatPacket.Player = playerInfo;

        ServerSession serverSession = session as ServerSession;

        //if (chatPacket.playerId == 1)
        //Console.WriteLine(chatPacket.chat);
    }

    public static void S_RoomInfoHandler(PacketSession session, IMessage packet)
    {
    }


    public static void S_JoinGameRoomHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_LeaveGameRoomHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_SpawnHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_DespawnHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_StartGameHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_ShootHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_MoveHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_NextBubblesHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_NextBubblesPeerHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_NextColsBubbleHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_NextColsBubblePeerHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_NextColsBubbleListHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_FixedBubbleSlotPeerHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_PlayerGameOverBroadCastHandler(PacketSession session, IMessage packet)
    {
    }

    public static void S_GameResultHandler(PacketSession session, IMessage packet)
    {
    }
}

