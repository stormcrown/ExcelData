package cn.dovahkiin.model;

import cn.dovahkiin.commons.utils.StringUtils;
import com.baomidou.mybatisplus.enums.IdType;

import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;

import java.io.Serializable;

/**
 * <p>
 * 客户信息
 * </p>
 *
 * @author lzt
 * @since 2018-11-29
 */
@TableName("true_customer")
public class TrueCustomer extends Model<TrueCustomer> {

    private static final long serialVersionUID = 1L;

//    public static String guessName(String customerName) {
//        if (StringUtils.hasText(customerName)) {
//            if (customerName.contains("-")) customerName = customerName.substring(0, customerName.indexOf("-"));
//            if (customerName.contains("（")) customerName = customerName.substring(0, customerName.indexOf("（"));
//            if (customerName.contains("(")) customerName = customerName.substring(0, customerName.indexOf("("));
//            int strLen = customerName.length();
//            int limitLen=2;
//            if(StringUtils.isInteger(customerName.trim()))limitLen=3;
//            StringBuffer str = new StringBuffer(customerName);
//            for (int i = strLen - 1; i > -1; i--) {
//                char ar = str.charAt(i);
//                if (
//                        (
//                                Character.isDigit(ar)
//                                || Character.compare(' ', ar) == 0
//                        )
//                                && str.length() > limitLen
//                    ) {
//                    str.deleteCharAt(i);
//                }else break;
//            }
////            if(str.length()>3 && str.toString().toUpperCase().endsWith("APP") )str.delete(str.length()-3,str.length());
//            return str.toString();
//        }
//        return customerName;
//    }

    public TrueCustomer() {
    }

    public TrueCustomer(String name, Date updateTime, Date createTime, Integer deleteFlag) {
        this.name = name;
        this.updateTime = updateTime;
        this.createTime = createTime;
        this.deleteFlag = deleteFlag;
    }

    /**
     * 主键id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    /**
     * 客户名
     */
    private String name;
    /**
     * 客户编码
     */
    private String code;
    private static final String codePrex="TCUS";
    public   String CreateCode(){
        StringBuffer newCode= new StringBuffer()
                .append(codePrex)
                .append(StringUtils.getDateCode())
                .append(this.hashCode())
                ;
        if(this.code==null)this.code=newCode.toString();
        return newCode.toString();
    }
    /**
     * 更新时间
     */
    @TableField("update_time")
    private Date updateTime;
    /**
     * 创建时间
     */
    @TableField("create_time")
    private Date createTime;
    /**
     * 是否删除
     */
    @TableField("delete_flag")
    private Integer deleteFlag;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(Integer deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
