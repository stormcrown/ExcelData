package cn.dovahkiin.test;

import cn.dovahkiin.commons.converter.DateConverter;
import cn.dovahkiin.model.Industry;
import org.junit.Test;

import java.util.Arrays;
import java.util.Date;

public class other {
    @Test
    public void tetss(){
        Object j = new Object();
        Industry industry1 = new Industry();
        industry1.CreateCode();

        Industry industry2 = new Industry();
        industry2.CreateCode();
        System.out.println(industry1 == industry2);
        System.out.println(industry1.hashCode()+"\t"+industry2.hashCode());
    }
    @Test
    public void order(){
//        int[] nums = new int[]{  42,64,621,5,84,857,185,85,1,61,167,126,103,611,3,66,89,13,168,98,11,6,896,174,156,809,16, };
//        Arrays.sort(nums);
//        for(int i:nums) System.out.print(i+",");
        int[] nums2 = new int[]{  42,64,621,5,84,857,185,85,1,61,167,126,103,611,3,66,89,13,168,98,11,6,896,174,156,809,16, };
        for(int i=0;i<nums2.length;i++){
            for(int j=0;j<nums2.length;j++){
                if(nums2[i] < nums2[j]){
                    int temp = nums2[i];
                    nums2[i] =nums2[j];
                    nums2[j] = temp;
                }
            }
        }
        System.out.println();
        for(int i=0;i<nums2.length;i++) System.out.print(nums2[i]+",");
    }
    @Test
    public void max(){
        int[] nums = new int[]{  1,2,3,5,8,7,9,6 };
        StringBuilder stringBuilder = new StringBuilder();
        Arrays.sort(nums);
        for(int i=nums.length-1;i>=0;i--) stringBuilder.append(nums[i]);
        System.out.println(stringBuilder);
    }
}
