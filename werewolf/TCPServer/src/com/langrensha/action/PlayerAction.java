package com.langrensha.action;

import java.util.List;

import com.langrensha.client.Event;
import com.langrensha.dao.PlayerDao;
import com.langrensha.model.*;
import com.langrensha.server.Room;
import com.langrensha.utility.Message;

public class PlayerAction {
	private PlayerDao playerDao;
	private int day;

	public PlayerAction() {
		playerDao = new PlayerDao();
		day = 1;
	}
public String[] getAllPlayerNames(){
	List<Player> players= playerDao.getList();
	int size=players.size();
	String[] names=new String[size];
	for(int i=0;i<size;i++){
		names[i]=players.get(i).getName();
	}
	return names;
}
	public void addPlayer(Player player) {
		playerDao.add(player);
	}

	public Player getPlayer(int playerId) {
		return playerDao.get(playerId);
	}

	public List<Player> getPlayersByRole(int roleId) {
		return playerDao.getPlayersByRole(roleId);
	}

	public void distribution(int playerId, int roleId) {
		Player player = playerDao.get(playerId);
		Role role = null;
		switch (roleId) {
		case Role.CUPID:
			role = new Cupid();
			break;
		case Role.HUNTER:
			role = new Hunter();
			break;
		case Role.SEER:
			role = new Seer();
			break;
		case Role.THIEF:
			role = new Thief();
			break;
		case Role.VILLAGER:
			role = new Villager();
			break;
		case Role.WITCH:
			role = new Witch();
			break;
		case Role.WOLF:
			role = new Wolf();
			break;
		default:
			break;
		}
		player.setRole(role);
	}

	public boolean setSheriff(int sheriffId) {
		return playerDao.setSheriff(sheriffId);
	}

	public Player getSheriff() {
		return playerDao.getSheriff();
	}

	public List<Player> getDeadPlayers(int deadDay) {
		return playerDao.getDeadPlayers(deadDay);
	}

	public List<Player> getAlivePlayers() {
		return playerDao.getAlivePlayers();
	}

	// //////////////////////////////////////////////////////////////////////////////////
	public void nextDay() {
		day++;
		for (Player p : getAlivePlayers())
			p.getRole().setAliveDay(day);

	}

	public int today() {
		return day;
	}

	public void send(int playerId, Message msg) {
		String str = msg.toJson();
		Player p = playerDao.get(playerId);
		if (p != null)
			p.output(str);
	}

	public String recv(int playerId) {
		return playerDao.get(playerId).input();
	}

	public void vote(int voteId, int toVoteId) {
		Player votePlayer = playerDao.get(voteId);
		Player toVotePlayer = playerDao.get(toVoteId);
		votePlayer.getRole().getVoteList().add(toVotePlayer.getName());

	}

	public void theifAction(Player tp, int roleId) {
		Thief thief = (Thief) tp.getRole();
		Role newRole = thief.steal(roleId);
		tp.setRole(newRole);
	}

	public void cupidAction(Player cp, int firstId, int secondId) {
		Cupid cupid = (Cupid) cp.getRole();
		Player first = playerDao.get(firstId);
		Player second = playerDao.get(secondId);
		cupid.shoot(first, second);
	}

	public int seerAction(Player sp, int toSeeId) {
		Seer seer = (Seer) sp.getRole();
		Player toSeePlayer = playerDao.get(toSeeId);
		return seer.see(toSeePlayer);
	}

	public int[] wolfAction(Player wp, int toKillId) {
		Wolf wolf = (Wolf) wp.getRole();
		Player toKillPlayer = playerDao.get(toKillId);
		wolf.kill(toKillPlayer);
		// 情侣殉情
		int secondId = loverAction(toKillPlayer);
		if (secondId != 0) {
			int[] deadIds = { toKillId, secondId };
			return deadIds;
		} else {
			int[] deadIds = { toKillId };
			return deadIds;
		}

	}

	public int[] witchSaveAction(Player wip, int toSaveId) {
		Witch witch = (Witch) wip.getRole();
		Player toSavePlayer = playerDao.get(toSaveId);
		if (witch.save(toSavePlayer)) {
			// 情侣也复活
			int secondId = toSavePlayer.getRole().getLoverId();
			if (secondId != 0) {
				Role secondRole = playerDao.get(secondId).getRole();
				if (secondRole.getStatus() == Role.SUICIDED) {
					secondRole.setStatus(Role.ALIVE);
					int[] surviveIds = { toSaveId, secondId };
					return surviveIds;
				}
			}
			int[] surviveIds = { toSaveId };
			return surviveIds;
		} else {
			return null;
		}
	}

	public int[] witchPoisonAction(Player wip, int toPoisonId) {
		Witch witch = (Witch) wip.getRole();
		Player toPoisonPlayer = playerDao.get(toPoisonId);
		if (witch.poison(toPoisonPlayer)) {
			// 情侣殉情
			int secondId = loverAction(toPoisonPlayer);
			if (secondId != 0) {
				int[] deadIds = { toPoisonId, secondId };
				return deadIds;
			} else {
				int[] deadIds = { toPoisonId };
				return deadIds;
			}
		} else {
			return null;
		}
	}

	private int loverAction(Player first_player) {
		int secondId = first_player.getRole().getLoverId();
		if (secondId != 0) {
			Role secondRole = playerDao.get(secondId).getRole();
			if (secondRole.getStatus() == Role.ALIVE) {
				secondRole.setStatus(Role.SUICIDED);
			}
		}
		return secondId;

	}

	public int[] hunterAction(Player hp, int toHuntId) {
		Hunter hunter = (Hunter) hp.getRole();
		Player toHuntPlayer = playerDao.get(toHuntId);
		if (hunter.hunt(toHuntPlayer)) {
			// 情侣殉情
			int secondId = loverAction(toHuntPlayer);
			if (secondId != 0) {
				int[] deadIds = { toHuntId, secondId };
				return deadIds;
			} else {
				int[] deadIds = { toHuntId };
				return deadIds;
			}
		}
		return null;
	}

	public int[] viliagerAction(int toExecuteId) {
		Player toExecutePlayer = playerDao.get(toExecuteId);
		toExecutePlayer.getRole().setStatus(Role.EXECUTED);
		// 情侣殉情
		int secondId = loverAction(toExecutePlayer);
		if (secondId != 0) {
			int[] deadIds = { toExecuteId, secondId };
			return deadIds;
		} else {
			int[] deadIds = { toExecuteId };
			return deadIds;
		}
	}

	public void sheriffAction(Player oldSheriff, int newSheriffId) {
		oldSheriff.getRole().setSheriff(false);
		playerDao.get(newSheriffId).getRole().setSheriff(true);
	}

	/**
	 * 判断游戏是否结束
	 * 
	 * @return VILLAGER_WIN 村民阵营胜利；LOVER_WIN 情侣阵营胜利；WOLF_WIN 狼人阵营胜利；ON_GAME
	 *         游戏进行中
	 */
	public int isGameOver() {
		List<Player> alivePlayers = playerDao.getAlivePlayers();
		if (alivePlayers.size() == 0)
			return Event.EQUAL;
		else if (alivePlayers.size() == 2) {
			// 只存活两人(其中一人是狼人，另一人身份不明，但是其爱人)，情侣阵营胜利
			Player firstPlayer = alivePlayers.get(0);
			Player secondPlayer = alivePlayers.get(1);
			if (firstPlayer.getRole().getId() == Role.WOLF
					|| secondPlayer.getRole().getId() == Role.WOLF) {
				int loverId = firstPlayer.getRole().getLoverId();
				int secondId = secondPlayer.getId();
				if (loverId == secondId)
					return Event.LOVER_WIN;
			}
		}
		boolean isWolfWin = true;
		boolean isVillagerWin = true;
		for (Player p : alivePlayers) {
			int roleId = p.getRole().getId();
			if (roleId != Role.WOLF)
				isWolfWin = false;// 只要有村民存活，狼人阵营就不可能胜利
			else if (roleId == Role.WOLF)
				isVillagerWin = false;// 只要有狼人存活，村民阵营就不可能胜利
		}
		if (isWolfWin)
			return Event.WOLF_WIN;
		if (isVillagerWin)
			return Event.VILLAGER_WIN;

		return Event.ON_GAME;
	}
}
