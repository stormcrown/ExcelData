package cn.dovahkiin.service;

import cn.dovahkiin.model.Customer;
import cn.dovahkiin.model.Supplier;
import cn.dovahkiin.model.VideoCost;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import org.springframework.ui.Model;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 客户信息 服务类
 * </p>
 *
 * @author lzt
 * @since 2018-11-03
 */
public interface ICustomerService {
    int deleteByPrimaryKey(Long id);
    int insert(Customer record);
    int insertSelective(Customer record);
    Customer selectByPrimaryKey(Long id);
    List<Customer> selectByCode(String code);
    List<Customer> selectUnDeleted(Supplier supplier);
    List<Customer> selectForCombobox(Long supplierId);
    List<Customer> selectList(Map map);
    int countAll(Customer customer);
    int countFrCheckCodeVersion(String code ,Long versionId,Long selfId);
    Page<Customer> selectPage(Page<Customer> pages, Map<String , Object> map);
    int updateByPrimaryKeySelective(Customer record);
    int updateByPrimaryKey(Customer record);
    int deleteMany(List<String> ids);
    int rollBack(List<String> ids);
//    Model modelForEdit(Model model);
    int deleteFlagIsOne();
}
