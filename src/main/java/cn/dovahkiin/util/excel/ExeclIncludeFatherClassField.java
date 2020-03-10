
package cn.dovahkiin.util.excel;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 在类名上注解，表明该类的excel信息还包括父一级类
 *
 * @author 骆长涛
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface ExeclIncludeFatherClassField {
}