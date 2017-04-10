package com.hbsd.bean.job;

import java.io.IOException;
import java.io.InputStream;
import java.io.Writer;
import java.math.BigInteger;
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.client.fluent.Request;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.google.gson.Gson;
import com.hbsd.bean.job.weixin.Openid;
import com.hbsd.bean.job.weixin.Token;
import com.hbsd.bean.job.weixin.WX_User;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.core.util.QuickWriter;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import com.thoughtworks.xstream.io.xml.PrettyPrintWriter;
import com.thoughtworks.xstream.io.xml.XppDriver;

/**
 * 微信相关工具类
 */
public class WeixinUtil {

	static final String TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential";
	public static final String appID = "wx7661e84d93beeffb";
	public static final String appsecret = "01e32cd5b265aafbc4eed82a4fa774df";
	public static String MyTOKEN = null;

	static Gson gson = new Gson();
	// appid=APPID&secret=SECRET&code=CODE&grant_type=authorization_code
	static final String OpenIDURL = "https://api.weixin.qq.com/sns/oauth2/access_token?";
	static final String refresh_TOKEN_URL = "https://api.weixin.qq.com/sns/oauth2/refresh_token?";

	static final String GetWX_UserURL = "https://api.weixin.qq.com/cgi-bin/user/info?";

	public static String getTOKENc(boolean ref) {

		if (ref) {
			MyTOKEN = getHTTPTOKEN();
		} else {
			if (MyTOKEN == null) {

				MyTOKEN = getHTTPTOKEN();
			}
		}

		return MyTOKEN;

	}

	public static String getTOKENc() {

		getTOKENc(false);

		return MyTOKEN;

	}

	public static WX_User getWXUser(String token, String openid) {

		try {
			String URL = GetWX_UserURL + "access_token=" + getTOKENc()
					+ "&openid=" + openid + "&lang=zh_CN";
			String jsonstr = Request.Get(URL).execute().returnContent()
					.asString(Charset.forName("utf-8"));

			WX_User obj = gson.fromJson(jsonstr, WX_User.class);
			return obj;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;

	}

	public static Openid getrefresh_token(String refresh_token) {
		String URL = refresh_TOKEN_URL + "appid=" + appID
				+ "&grant_type=refresh_token&refresh_token=" + refresh_token;

		try {
			String jsonstr = Request.Get(URL).execute().returnContent()
					.asString();

			Openid Openid = gson.fromJson(jsonstr, Openid.class);
			return Openid;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public static Openid getOpenID(String code) {
		String URL = OpenIDURL + "appid=" + appID + "&secret=" + appsecret
				+ "&code=" + code + "&grant_type=authorization_code";
		try {
			String jsonstr = Request.Get(URL).execute().returnContent()
					.asString(Charset.forName("utf-8"));

			Openid Openid = gson.fromJson(jsonstr, Openid.class);
			return Openid;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	private static String getHTTPTOKEN() {
		// appid=APPID&secret=APPSECRET
		try {

			String jsonstr = Request
					.Get(TOKEN_URL + "&appid=" + appID + "&secret=" + appsecret)
					.execute().returnContent().asString();

			Token t = gson.fromJson(jsonstr, Token.class);
			MyTOKEN = t.getAccess_token();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return MyTOKEN;

	}

	public static String singleExamMarkToString(ExamMark em) {
		if (null == em || em.getExam() == null)
			return null;
		StringBuilder sb = new StringBuilder();
		return sb.toString();
	}

	private static XStream xstream = new XStream(new XppDriver() {
		public HierarchicalStreamWriter createWriter(Writer out) {
			return new PrettyPrintWriter(out) {
				// 对所有xml节点的转换都增加CDATA标记
				boolean cdata = true;

				@SuppressWarnings("unchecked")
				public void startNode(String name, Class clazz) {
					super.startNode(name, clazz);
				}

				protected void writeText(QuickWriter writer, String text) {
					if (cdata) {
						writer.write("<![CDATA[");
						writer.write(text);
						writer.write("]]>");
					} else {
						writer.write(text);
					}
				}
			};
		}
	});

	/**
	 * 将回复消息对象转换成xml字符串
	 * 
	 * @param reply
	 *            回复消息对象
	 * @return 返回符合微信接口的xml字符串
	 */
	public static String replyToXml(Reply reply) {
		String type = reply.getMsgType();
		if (Reply.TEXT.equals(type)) {
			xstream.omitField(Reply.class, "articles");
			xstream.omitField(Reply.class, "articleCount");
			xstream.omitField(Reply.class, "musicUrl");
			xstream.omitField(Reply.class, "hQMusicUrl");
		} else if (Reply.MUSIC.equals(type)) {
			xstream.omitField(Reply.class, "articles");
			xstream.omitField(Reply.class, "articleCount");
			xstream.omitField(Reply.class, "content");
		} else if (Reply.NEWS.equals(type)) {
			xstream.omitField(Reply.class, "content");
			xstream.omitField(Reply.class, "musicUrl");
			xstream.omitField(Reply.class, "hQMusicUrl");
		}
		xstream.autodetectAnnotations(true);
		xstream.alias("xml", reply.getClass());
		xstream.alias("item", new Article().getClass());
		return xstream.toXML(reply);
	}

	/**
	 * 存储数据的Map转换为对应的Message对象
	 * 
	 * @param map
	 *            存储数据的map
	 * @return 返回对应Message对象
	 */
	public static Message mapToMessage(Map<String, String> map) {
		if (map == null)
			return null;
		String msgType = map.get("MsgType");
		Message message = new Message();
		message.setToUserName(map.get("ToUserName"));
		message.setFromUserName(map.get("FromUserName"));
		message.setCreateTime(new Date(Long.parseLong(map.get("CreateTime"))));
		message.setMsgType(msgType);
		message.setMsgId(map.get("MsgId"));
		if (msgType.equals(Message.TEXT)) {
			message.setContent(map.get("Content"));
		} else if (msgType.equals(Message.IMAGE)) {
			message.setPicUrl(map.get("PicUrl"));
		} else if (msgType.equals(Message.LINK)) {
			message.setTitle(map.get("Title"));
			message.setDescription(map.get("Description"));
			message.setUrl(map.get("Url"));
		} else if (msgType.equals(Message.LOCATION)) {
			message.setLocationX(map.get("Location_X"));
			message.setLocationY(map.get("Location_Y"));
			message.setScale(map.get("Scale"));
			message.setLabel(map.get("Label"));
		} else if (msgType.equals(Message.EVENT)) {
			message.setEvent(map.get("Event"));
			message.setEventKey(map.get("EventKey"));
		}
		return message;
	}

	/**
	 * 解析request中的xml 并将数据存储到一个Map中返回
	 * 
	 * @param request
	 */
	public static Map<String, String> parseXml(HttpServletRequest request) {
		Map<String, String> map = new HashMap<String, String>();
		try {
			InputStream inputStream = request.getInputStream();
			SAXReader reader = new SAXReader();
			Document document = reader.read(inputStream);
			Element root = document.getRootElement();
			List<Element> elementList = root.elements();
			for (Element e : elementList)
				// 遍历xml将数据写入map
				map.put(e.getName(), e.getText());
			inputStream.close();
			inputStream = null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	/**
	 * sha1加密算法
	 * 
	 * @param key需要加密的字符串
	 * @return 加密后的结果
	 */
	public static String sha1(String key) {
		try {
			MessageDigest md = MessageDigest.getInstance("SHA1");
			md.update(key.getBytes());
			String pwd = new BigInteger(1, md.digest()).toString(16);
			return pwd;
		} catch (Exception e) {
			e.printStackTrace();
			return key;
		}
	}

}
