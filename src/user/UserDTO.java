package user;

public class UserDTO {
	private String userID;
	private String userPassword;
	private String userName;
	private String userTel;
	private char userGender;
	private String userEmail;
	private char mailOk;
	private char smsOk;
	private String info;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public char getUserGender() {
		return userGender;
	}
	public void setUserGender(char userGender) {
		this.userGender = userGender;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public char getMailOk() {
		return mailOk;
	}
	public void setMailOk(char mailOk) {
		this.mailOk = mailOk;
	}
	public char getSmsOk() {
		return smsOk;
	}
	public void setSmsOk(char smsOk) {
		this.smsOk = smsOk;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
}

