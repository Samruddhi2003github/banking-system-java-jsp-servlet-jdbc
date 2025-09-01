package com.aurionpro.dao;

import java.sql.*;
import java.util.*;

import com.aurionpro.model.Account;
import com.aurionpro.util.DBUtil;

public class AccountDao {

	// Create a new account for a customer
	public boolean createAccount(Account account) {
		String sql = "INSERT INTO accounts(user_id, account_number, account_type, balance, status) VALUES(?,?,?,?,?)";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, account.getUserId());
			ps.setLong(2, account.getAccountNumber());
			ps.setString(3, account.getAccountType()); // 'Savings' or 'Current'
			ps.setBigDecimal(4, account.getBalance());
			ps.setString(5, account.getStatus()); // 'Pending' or 'Active'

			int rows = ps.executeUpdate();
			return rows > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Fetch account details by userId
	public Account getAccountByUserId(int userId) {
		String sql = "SELECT * FROM accounts WHERE user_id=?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, userId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				Account acc = new Account();
				acc.setAccountId(rs.getInt("account_id"));
				acc.setUserId(rs.getInt("user_id"));
				acc.setAccountNumber(rs.getLong("account_number"));
				acc.setAccountType(rs.getString("account_type"));
				acc.setBalance(rs.getBigDecimal("balance"));
				acc.setStatus(rs.getString("status"));
				acc.setCreatedAt(rs.getTimestamp("created_at"));
				return acc;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// Get all accounts (for admin dashboard)
	public List<Account> getAllAccounts() {
		List<Account> accounts = new ArrayList<>();
		String sql = "SELECT * FROM accounts";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Account acc = new Account();
				acc.setAccountId(rs.getInt("account_id"));
				acc.setUserId(rs.getInt("user_id"));
				acc.setAccountNumber(rs.getLong("account_number"));
				acc.setAccountType(rs.getString("account_type"));
				acc.setBalance(rs.getBigDecimal("balance"));
				acc.setStatus(rs.getString("status"));
				acc.setCreatedAt(rs.getTimestamp("created_at"));
				accounts.add(acc);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return accounts;
	}

	// Approve account (set status to Active)
	public boolean approveAccount(int accountId) {
		String sql = "UPDATE accounts SET status='Active' WHERE account_id=?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, accountId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// Update account balance
	public boolean updateBalance(int accountId, double newBalance) {
		String sql = "UPDATE accounts SET balance=? WHERE account_id=?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setDouble(1, newBalance);
			ps.setInt(2, accountId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public List<Account> getAllPendingAccounts() {
		List<Account> accounts = new ArrayList<>();
		String sql = "SELECT * FROM accounts WHERE status='Pending'";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Account acc = new Account();
				acc.setAccountId(rs.getInt("account_id"));
				acc.setUserId(rs.getInt("user_id"));
				acc.setAccountNumber(rs.getLong("account_number"));
				acc.setAccountType(rs.getString("account_type"));
				acc.setBalance(rs.getBigDecimal("balance"));
				acc.setStatus(rs.getString("status"));
				accounts.add(acc);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return accounts;
	}

	public Account getAccountByAccountNumber(long accountNumber) {
		String sql = "SELECT * FROM accounts WHERE account_number=?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setLong(1, accountNumber);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				Account acc = new Account();
				acc.setAccountId(rs.getInt("account_id"));
				acc.setUserId(rs.getInt("user_id"));
				acc.setAccountNumber(rs.getLong("account_number"));
				acc.setAccountType(rs.getString("account_type"));
				acc.setBalance(rs.getBigDecimal("balance"));
				acc.setStatus(rs.getString("status"));
				acc.setCreatedAt(rs.getTimestamp("created_at"));
				return acc;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
