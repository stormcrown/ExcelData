package cn.dovahkiin.test.excel;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cn.dovahkiin.commons.report.excel.EasyExcel;
import cn.dovahkiin.commons.utils.JsonUtils;
import cn.dovahkiin.util.excel.CommonReadListenter;
import com.alibaba.excel.ExcelReader;
import com.alibaba.excel.support.ExcelTypeEnum;
import com.alibaba.fastjson.JSON;
import org.junit.Test;

/**
 * Created by chunmeng.lu
 * Date: 2016-20-04 10:42
 */
public class ExcelTest {

	public static void main(String[] args) throws Exception {
		testCreateExcel();
//		testParse();
	}

	public static void testCreateExcel() throws Exception {
		EasyExcel fastExcel = new EasyExcel("/Users/lcm/Desktop/data.xlsx");
		List<MyTest> list = new ArrayList<MyTest>();
		for (int i = 0; i < 10; i++) {
			MyTest test = new MyTest();
			test.setName("张三" + i);
			test.setPhone("15321111111");
			test.setAddress("三里屯");
			test.setLat(135.11111);
			test.setType(1);
			test.setPrice(i * 1.1);
			test.setSize(i);
			test.setDateTime(new Date());
			test.setXx(i % 2 == 0);
			list.add(test);
		}
		fastExcel.createExcel(list);
		fastExcel.close();
	}

	public static void testParse() throws Exception {
		EasyExcel fastExcel = new EasyExcel("/Users/lcm/Desktop/data.xlsx");
		fastExcel.setSheetName("Sheet1");
		List<MyTest> tests = fastExcel.parse(MyTest.class);
		if(null != tests && !tests.isEmpty()) {
			for(MyTest myTest : tests) {
				System.out.println(JsonUtils.toJson(myTest));
			}
		} else {
			System.out.println("没有结果");
		}
		fastExcel.close();
	}
	@Test
	public void read() throws IOException {
		InputStream inputStream = new FileInputStream("E:/Develop/导入数据模板.xlsx");
		CommonReadListenter listenter = new CommonReadListenter();
		ExcelReader reader = new ExcelReader(inputStream, ExcelTypeEnum.XLSX, listenter, true);
		reader.read();
		List<ArrayList<Object>> list = listenter.data;
		for (ArrayList arrayList  :list) {
			System.out.println(JSON.toJSONString(arrayList));
		}
	}
}
