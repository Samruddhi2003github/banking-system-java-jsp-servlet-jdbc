package com.aurionpro.service;

import java.util.List;

import com.aurionpro.dao.TxnDao;
import com.aurionpro.model.Txn;

public class TxnService {
private TxnDao txnDAO = new TxnDao();
    
    public void addTransaction(Txn txn) {
        txnDAO.addTransaction(txn);
    }
    
    public List<Txn> getPassbook(int accountId) {
        return txnDAO.getTransactionsByAccountId(accountId);
    }
    
    public List<Txn> getAllTransactions(int txn_id) {
        return txnDAO.getTransactionsByAccountId(txn_id);
    }
}

