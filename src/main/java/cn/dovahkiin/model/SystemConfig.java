package cn.dovahkiin.model;

import cn.dovahkiin.commons.utils.DateTools;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
@TableName("system_config")
public class SystemConfig extends Model<SystemConfig> {

    private static final long serialVersionUID = 1L;
	public static final long ID = 1L;
	private Long id ;

	public SystemConfig() {
	}
	public SystemConfig(Long id, Integer deleteFlag) {
		this.id = id;
		this.deleteFlag = deleteFlag;
	}

	/**
     * 收入比率，百分比。
     */
	@TableField("default_income_ratio")
	private Double defaultIncomeRatio;
	@TableField("default_pay_ratio")
	private Double defaultPayRatio;
    /**
     * 默认最大有效消耗
     */
	@TableField("default_max_effect_con")
	private Double defaultMaxEffectCon;
	@TableField("default_pay_max_effect_con")
	private Double defaultPayMaxEffectCon;
    /**
     * 默认生命周期
     */
	@TableField("default_max_effect_range")
	private Integer defaultMaxEffectRange;

	/**
	 * 更新时间
	 */
	@TableField("update_time")
	private Date updateTime;
	@TableField(exist = false)
	private String updateTimeStr;

	@TableField("update_by")
	private Long updateBy;
	/**
	 * 是否删除
	 */
	@TableField("delete_flag")
	private Integer deleteFlag;
	@TableField(exist = false)
	private String updater;

	@TableField(exist = false)
	private Supplier supplier;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Double getDefaultIncomeRatio() {
		return defaultIncomeRatio;
	}

	public void setDefaultIncomeRatio(Double defaultIncomeRatio) {
		this.defaultIncomeRatio = defaultIncomeRatio;
	}

	public Double getDefaultMaxEffectCon() {
		return defaultMaxEffectCon;
	}

	public void setDefaultMaxEffectCon(Double defaultMaxEffectCon) {
		this.defaultMaxEffectCon = defaultMaxEffectCon;
	}

	public Double getDefaultPayMaxEffectCon() {
		return defaultPayMaxEffectCon;
	}

	public void setDefaultPayMaxEffectCon(Double defaultPayMaxEffectCon) {
		this.defaultPayMaxEffectCon = defaultPayMaxEffectCon;
	}

	public Integer getDefaultMaxEffectRange() {
		return defaultMaxEffectRange;
	}

	public void setDefaultMaxEffectRange(Integer defaultMaxEffectRange) {
		this.defaultMaxEffectRange = defaultMaxEffectRange;
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

	public String getUpdater() {
		return updater;
	}

	public void setUpdater(String updater) {
		this.updater = updater;
	}

	public String getUpdateTimeStr() {
		if(updateTime!=null)return DateTools.getDateTimeStr(updateTime);
		return updateTimeStr;
	}
	public void setUpdateTimeStr(String updateTimeStr) {
		this.updateTimeStr = updateTimeStr;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplier(Supplier supplier) {
		this.supplier = supplier;
	}

	public Double getDefaultPayRatio() {
		return defaultPayRatio;
	}

	public void setDefaultPayRatio(Double defaultPayRatio) {
		this.defaultPayRatio = defaultPayRatio;
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
