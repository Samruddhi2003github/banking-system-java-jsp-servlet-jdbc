package com.aurionpro.dao;

import java.sql.*;
import java.util.*;
import com.aurionpro.model.Beneficiary;
import com.aurionpro.util.DBUtil;

public class BeneficiaryDao {
    public boolean addBeneficiary(Beneficiary b) {
        String sql = "INSERT INTO beneficiaries(user_id, name, account_number, ifsc_code, relation) VALUES(?,?,?,?,?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, b.getUserId());
            ps.setString(2, b.getName());
            ps.setLong(3, b.getAccountNumber());
            ps.setString(4, b.getIfscCode());
            ps.setString(5, b.getRelation());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    
    public List<Beneficiary> getBeneficiariesByUserId(int userId) {
        List<Beneficiary> list = new ArrayList<>();
        String sql = "SELECT * FROM beneficiaries WHERE user_id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Beneficiary b = new Beneficiary();
                b.setBeneficiaryId(rs.getInt("beneficiary_id"));
                b.setUserId(rs.getInt("user_id"));
                b.setName(rs.getString("name"));
                b.setAccountNumber(rs.getLong("account_number"));
                b.setIfscCode(rs.getString("ifsc_code"));
                b.setRelation(rs.getString("relation"));
                list.add(b);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
