package cn.dovahkiin.model;

import cn.dovahkiin.commons.utils.JsonUtils;
import cn.dovahkiin.commons.utils.StringUtils;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.fasterxml.jackson.annotation.JsonProperty;
import cn.dovahkiin.commons.utils.JsonUtils;
import org.hibernate.validator.constraints.NotBlank;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * 组织机构
 *
 */
public class Organization extends Model<Organization>  {
	private static final String codePrex="ORG";
	public   String CreateCode(){
		StringBuffer newCode= new StringBuffer()
		.append(codePrex)
				.append(StringUtils.getDateCode())
				.append(this.hashCode())
		;
		if(this.code==null)this.code=newCode.toString();
		return newCode.toString();
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	private static final long serialVersionUID = 2L;

	/** 主键id */
	private Long id;

	/** 组织名 */
	@NotBlank
	private String name;
	@TableField("simple_names")
	private String simpleNames;

	/** 地址 */
	private String address;

	/** 编号 */
	@NotBlank
	private String code;

	/** 图标 */
	@JsonProperty("iconCls")
	private String icon;

	/** 父级主键 */
	private Long pid;

	/** 排序 */
	private Integer seq;

	/** 创建时间 */
	private Date createTime;

	public Organization() {
	}

	public Organization(String name, String code, Integer seq, Date createTime) {
		this.name = name;
		this.code = code;
		this.seq = seq;
		this.createTime = createTime;
	}

	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getIcon() {
		return this.icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Long getPid() {
		return this.pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public Integer getSeq() {
		return this.seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getSimpleNames() {
		return simpleNames;
	}

	public void setSimpleNames(String simpleNames) {
		this.simpleNames = simpleNames;
	}

	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}

}
