package grades;

public class GradesDTO {
	private int gradesID;
	private String userID;
	private String type;
	private int grade;
	private int semester;
	private String subject;
	private int score;
	
	public int getGradesID() {
		return gradesID;
	}
	public void setGradesID(int gradesID) {
		this.gradesID = gradesID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getSemester() {
		return semester;
	}
	public void setSemester(int semester) {
		this.semester = semester;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
}

