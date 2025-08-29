package com.aurionpro.model;

public class Beneficiary {
	 private int beneficiaryId;
	    private int userId;
	    private String name;
	    private long accountNumber;
	    private String ifscCode;
	    private String relation;
		public Beneficiary() {
			super();
		}
		public Beneficiary(int beneficiaryId, int userId, String name, long accountNumber, String ifscCode,
				String relation) {
			super();
			this.beneficiaryId = beneficiaryId;
			this.userId = userId;
			this.name = name;
			this.accountNumber = accountNumber;
			this.ifscCode = ifscCode;
			this.relation = relation;
		}
		public int getBeneficiaryId() {
			return beneficiaryId;
		}
		public void setBeneficiaryId(int beneficiaryId) {
			this.beneficiaryId = beneficiaryId;
		}
		public int getUserId() {
			return userId;
		}
		public void setUserId(int userId) {
			this.userId = userId;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public long getAccountNumber() {
			return accountNumber;
		}
		public void setAccountNumber(long accountNumber) {
			this.accountNumber = accountNumber;
		}
		public String getIfscCode() {
			return ifscCode;
		}
		public void setIfscCode(String ifscCode) {
			this.ifscCode = ifscCode;
		}
		public String getRelation() {
			return relation;
		}
		public void setRelation(String relation) {
			this.relation = relation;
		}
	    
}
