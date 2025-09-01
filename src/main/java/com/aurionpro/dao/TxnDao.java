package com.aurionpro.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.aurionpro.model.Txn;
import com.aurionpro.util.DBUtil;

public class TxnDao {
	public void addTransaction(Txn txn) {
        String sql = "INSERT INTO transactions (account_id, beneficiary_id, amount, txn_type, remarks) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, txn.getAccountId());
            
            if (txn.getBeneficiaryId() != null) {
                ps.setInt(2, txn.getBeneficiaryId());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            
            ps.setBigDecimal(3, txn.getAmount());
            ps.setString(4, txn.getTxnType());
            ps.setString(5, txn.getRemarks());
            
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Fetch transaction history by accountId
    public List<Txn> getTransactionsByAccountId(int accountId) {
        List<Txn> txnList = new ArrayList<>();
        String sql = "SELECT * FROM transactions WHERE account_id = ? ORDER BY txn_date DESC";
        
        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Txn txn = new Txn(
                    rs.getInt("txn_id"),
                    rs.getInt("account_id"),
                    rs.getObject("beneficiary_id") != null ? rs.getInt("beneficiary_id") : null,
                    rs.getBigDecimal("amount"),
                    rs.getString("txn_type"),
                    rs.getString("remarks"),
                    rs.getTimestamp("txn_date")
                );
                txnList.add(txn);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return txnList;
    }
    
 
    public List<Txn> getAllTransactions() {
        List<Txn> txns = new ArrayList<>();
        String sql = "SELECT * FROM transactions ORDER BY txn_date DESC";
        try(Connection conn=DBUtil.getConnection();
            PreparedStatement ps=conn.prepareStatement(sql);
            ResultSet rs=ps.executeQuery()){
            while(rs.next()){
                Txn t = new Txn(rs.getInt("txn_id"), 
                                rs.getInt("account_id"), 
                                rs.getObject("beneficiary_id") != null ? rs.getInt("beneficiary_id") : null, 
                                rs.getBigDecimal("amount"), 
                                rs.getString("txn_type"), 
                                rs.getString("remarks"),
                                rs.getTimestamp("txn_date"));
                txns.add(t);
            }
        }catch(Exception e){e.printStackTrace();}
        return txns;
    }

}

