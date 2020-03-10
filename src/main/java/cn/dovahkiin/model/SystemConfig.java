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
	public static final Long ID = 1L; // 默认的ID ，现在配置只有一套
	private Long id = ID;
    /**
     * 收入比率，百分比。
     */
	@TableField("default_income_ratio")
	private Double defaultIncomeRatio;
    /**
     * 默认最大有效消耗
     */
	@TableField("default_max_effect_con")
	private Double defaultMaxEffectCon;
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

	public String getUpdateTimeStr() {
		if(updateTime!=null)return DateTools.getDateTimeStr(updateTime);
		return updateTimeStr;
	}
	public void setUpdateTimeStr(String updateTimeStr) {
		this.updateTimeStr = updateTimeStr;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

}
