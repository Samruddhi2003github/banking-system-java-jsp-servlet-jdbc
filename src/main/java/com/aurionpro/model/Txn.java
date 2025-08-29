package com.aurionpro.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Txn {
	private int txnId;
    private int accountId;
    private Integer beneficiaryId; // can be null for deposits
    private BigDecimal amount;
    private String txnType; // Credit/Debit
    private String remarks;
    private Timestamp txnDate;
	public Txn() {
		super();
	}
	public Txn(int txnId, int accountId, Integer beneficiaryId, BigDecimal amount, String txnType, String remarks,
			Timestamp txnDate) {
		super();
		this.txnId = txnId;
		this.accountId = accountId;
		this.beneficiaryId = beneficiaryId;
		this.amount = amount;
		this.txnType = txnType;
		this.remarks = remarks;
		this.txnDate = txnDate;
	}
	public int getTxnId() {
		return txnId;
	}
	public void setTxnId(int txnId) {
		this.txnId = txnId;
	}
	public int getAccountId() {
		return accountId;
	}
	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}
	public Integer getBeneficiaryId() {
		return beneficiaryId;
	}
	public void setBeneficiaryId(Integer beneficiaryId) {
		this.beneficiaryId = beneficiaryId;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public String getTxnType() {
		return txnType;
	}
	public void setTxnType(String txnType) {
		this.txnType = txnType;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	public Timestamp getTxnDate() {
		return txnDate;
	}
	public void setTxnDate(Timestamp txnDate) {
		this.txnDate = txnDate;
	}
    
}
