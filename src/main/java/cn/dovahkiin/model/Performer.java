package cn.dovahkiin.model;

import cn.dovahkiin.commons.utils.JsonUtils;
import cn.dovahkiin.commons.utils.StringUtils;
import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;
import java.io.Serializable;

/**
 * <p>
 * 演员信息
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
public class Performer extends Model<Performer> {

    private static final long serialVersionUID = 2L;
	private static final String codePrex="PER";
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
     * 主键id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 演员名称
     */
	private String name;
    /**
     * 演员编码
     */
	private String code;
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

	public Performer() {
	}
	public static Performer craateForInsert(String name){
		Performer performer = new Performer();
		performer.name = name;
		performer.CreateCode();
		performer.createTime = new Date();
		performer.updateTime = new Date();
		performer.deleteFlag = 0;
		return performer;
	}
	public Performer(String name, String code, Date createTime, Integer deleteFlag) {
		this.name = name;
		this.code = code;
		this.createTime = createTime;
		this.deleteFlag = deleteFlag;
	}

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
	@Override
	public String toString() {
		return JsonUtils.toJson(this);
	}
}
