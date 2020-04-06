package cn.dovahkiin.model.dto;

import java.util.List;

public class CusCheckConfig {
    private String code;
    private String cusName;
    private List<CusRepeatConfig> configs;
    public String getCusName() {
        return cusName;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    public List<CusRepeatConfig> getConfigs() {
        return configs;
    }

    public void setConfigs(List<CusRepeatConfig> configs) {
        this.configs = configs;
    }
}
