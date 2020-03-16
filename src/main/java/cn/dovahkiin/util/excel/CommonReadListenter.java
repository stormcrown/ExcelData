package cn.dovahkiin.util.excel;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class CommonReadListenter extends AnalysisEventListener {
    public final List<ArrayList<Object>> data = new ArrayList<>();

    public CommonReadListenter() {
    }

    @Override
    public void invoke(Object o, AnalysisContext analysisContext) {
        data.add((ArrayList)o);
    }
    @Override
    public void doAfterAllAnalysed(AnalysisContext analysisContext) {
        try {
            InputStream in= analysisContext.getInputStream();
            in.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
