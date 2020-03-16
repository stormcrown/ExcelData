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
 * 
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
@TableName("price_level")
public class PriceLevel extends Model<PriceLevel> {

    private static final long serialVersionUID = 1L;
	private static final String codePrex="PLE";
	public String CreateCode(){
		StringBuilder newCode= new StringBuilder()
				.append(codePrex)
				.append(StringUtils.getDateCode())
				.append(this.hashCode())
				;
		if(this.code==null)this.code=newCode.toString();
		return newCode.toString();
	}
	public static PriceLevel craateForInsert(String name ,Long updateBy,Long createBy){
		PriceLevel priceLevel = new PriceLevel();
		priceLevel.name = name;
		priceLevel.CreateCode();
		priceLevel.createTime = new Date();
		priceLevel.updateTime = new Date();
		priceLevel.deleteFlag = 0;
		priceLevel.createBy=createBy;
		priceLevel.updateBy=updateBy;
		return priceLevel;
	}
    /**
     * 主键id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 分级名称
     */
	private String name;
    /**
     * 分级编码
     */
	private String code;
    /**
     * 固定价格
     */
	@TableField("base_price")
	private Double basePrice;
    /**
     * 更新时间
     */
	@TableField("update_time")
	private Date updateTime;
    /**
     * 更新人
     */
	@TableField("update_by")
	private Long updateBy;
    /**
     * 创建时间
     */
	@TableField("create_time")
	private Date createTime;
    /**
     * 创建人
     */
	@TableField("create_by")
	private Long createBy;
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

	public Double getBasePrice() {
		return basePrice;
	}

	public void setBasePrice(Double basePrice) {
		this.basePrice = basePrice;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Long getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(Long updateBy) {
		this.updateBy = updateBy;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getCreateBy() {
		return createBy;
	}

	public void setCreateBy(Long createBy) {
		this.createBy = createBy;
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
