package chenbo.LLK;
/**
* ���������
* �����߷���ҵ�������������
*/ 
public class UserData {
	private String name;
	private String date;
	private String hiScore;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHiScore() {
		return hiScore;
	}
	public void setHiScore(String hiScore) {
		this.hiScore = hiScore;
	}
	@Override
	public String toString() {
		return "UserData [date=" + date + ", hiScore=" + hiScore + ", name="
				+ name + "]";
	}
	
	
	
}
