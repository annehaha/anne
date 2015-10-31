package chenbo.LLK;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;



public class Configuration {               //��Ϸ��߷ּ�¼
	File file = new File("/sdcard/llk.dat");
	public Configuration(){
		load();	
	}
	
	public void save(UserData data){       //������߷ּ�¼���ļ�
		try {
			PrintWriter out = null;
			try {
				out = new PrintWriter(file,"utf-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	
			out.println(data.getName());
			out.println(data.getDate());
			out.println(data.getHiScore());
			out.close();
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}	
	}
	
	public UserData load(){            //���ļ����뵱ǰ��߷ּ�¼
		UserData data = null;
		try {
			data = new UserData();
			BufferedReader in = new BufferedReader(new InputStreamReader(
					new FileInputStream(file)));
			data.setName(in.readLine());
			data.setDate(in.readLine());
			data.setHiScore(in.readLine());
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return data;	
	}
	
	public String readFile(InputStream inputStream){   //��ʾ��߷�
		StringBuilder sb = new StringBuilder();
		try {
			BufferedReader in = new BufferedReader(new InputStreamReader(inputStream));
			String str = null;
			while((str=in.readLine()) != null){
				sb.append(str+"\n");
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		return sb.toString();
	}
}
