package cn.dovahkiin.task;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class DeleteDataForeverTask {
    protected Logger logger = LogManager.getLogger(getClass());
//    @Scheduled(cron = "0 0/5 * * * ?")
    public void deleteDataFlagIsOne(){
//        logger.warn("测试任务执行");


//        logger.warn("警告：开始删除delete_flag = 1 的无效数据");
    }
}
