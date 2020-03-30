package cn.dovahkiin.model;

import cn.dovahkiin.commons.utils.StringUtils;
import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author lzt
 * @since 2020-03-10
 */
public class Supplier extends Model<Supplier> {

    private static final long serialVersionUID = 1L;
	private static final String codePrex="SUP";
	public String CreateCode(){
		StringBuilder newCode= new StringBuilder()
				.append(codePrex)
				.append(StringUtils.getDateCode())
				.append(this.hashCode())
				;
		this.code=newCode.toString();
		return newCode.toString();
	}
	public static Supplier craateForInsert(String name){
		Supplier supplier = new Supplier();
		supplier.name = name;
		supplier.CreateCode();
		supplier.createTime = new Date();
		supplier.updateTime = new Date();
		supplier.deleteFlag = 0;
		return supplier;
	}

	public Supplier() {
	}
	public Supplier(Long id, Integer deleteFlag) {
		this.id = id;
		this.deleteFlag = deleteFlag;
	}

	/**
     * 主键id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 供应商名称
     */
    @NotNull(message = "名称不能为空")
	private String name;
    /**
     * 供应商编码
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
