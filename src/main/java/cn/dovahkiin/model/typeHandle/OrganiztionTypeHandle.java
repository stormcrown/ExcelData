//package cn.dovahkiin.model.typeHandle;
//
//import cn.dovahkiin.model.Organization;
//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;
//import org.apache.ibatis.type.BaseTypeHandler;
//import org.apache.ibatis.type.JdbcType;
//import org.apache.ibatis.type.MappedJdbcTypes;
//import org.apache.ibatis.type.MappedTypes;
//
//import java.sql.CallableStatement;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//
//@MappedJdbcTypes({JdbcType.BIGINT})
//@MappedTypes({Organization.class})
//public class OrganiztionTypeHandle extends BaseTypeHandler<Organization> {
//    public static final Log logger = LogFactory.getLog(OrganiztionTypeHandle.class);
//
//
//    @Override
//    public void setNonNullParameter(PreparedStatement preparedStatement, int i, Organization organization, JdbcType jdbcType) throws SQLException {
//        preparedStatement.setLong(i,organization.getId());
//    }
//
//    @Override
//    public Organization getNullableResult(ResultSet resultSet, String s) throws SQLException {
//        return null;
//    }
//
//    @Override
//    public Organization getNullableResult(ResultSet resultSet, int i) throws SQLException {
//        return null;
//    }
//
//    @Override
//    public Organization getNullableResult(CallableStatement callableStatement, int i) throws SQLException {
//        return null;
//    }
//}
