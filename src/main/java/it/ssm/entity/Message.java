package it.ssm.entity;

import java.util.HashMap;
import java.util.Map;

/* 通用的返回 json 数据的类 */
public class Message {
	
	private int code;		// 响应状态码  100:成功, 200:失败
	private String tips;	// 提示信息
	// 用户要返回给浏览器的数据
	private Map<String, Object> data = new HashMap<String, Object>();
	
	// 返回 Message 对象可以实现 add() 方法的连续调用
	public Message add(String key,Object value){
        this.getData().put(key, value);
        return this;
    }
	
    public static Message success(){		
    	Message message = new Message();
    	message.setCode(100);
    	message.setTips("处理成功!");
        return message;
    }
    
    public static Message fail(){
    	Message message = new Message();
    	message.setCode(200);
    	message.setTips("处理失败!");
        return message;
    }
    
    public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getTips() {
		return tips;
	}

	public void setTips(String tips) {
		this.tips = tips;
	}

	public Map<String, Object> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

}
