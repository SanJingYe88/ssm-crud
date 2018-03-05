package it.ssm.test;

import java.util.Arrays;
import java.util.List;

public class A<T> {

    private int pageNum;	//当前页的号码
    private int pageSize;    //每页的数量
    private int size;    //当前页的数量
    private String orderBy;    //排序

    //由于startRow和endRow不常用，这里说个具体的用法
    //可以在页面中"显示startRow到endRow 共size条数据"
    private int startRow;    //当前页面第一个元素在数据库中的行号
    private int endRow;    //当前页面最后一个元素在数据库中的行号
    
    private long total;    //总记录数
    private int pages;    //总页数
    private List<T> list;    //结果集
    
    private int firstPage;    //第一页
    private int prePage;    //前一页
    private int nextPage;    //下一页
    private int lastPage;    //最后一页

    private boolean isFirstPage = false;    //是否为第一页
    private boolean isLastPage = false;    //是否为最后一页
    private boolean hasPreviousPage = false;    //是否有前一页
    private boolean hasNextPage = false;    //是否有下一页
    private int navigatePages;    //导航页码数
    private int[] navigatepageNums;    //所有导航页号
    
    
	@Override
	public String toString() {
		return "A [pageNum=" + pageNum + ", pageSize=" + pageSize + ", size=" + size + ", orderBy=" + orderBy
				+ ", startRow=" + startRow + ", endRow=" + endRow + ", total=" + total + ", pages=" + pages + ", list="
				+ list + ", firstPage=" + firstPage + ", prePage=" + prePage + ", nextPage=" + nextPage + ", lastPage="
				+ lastPage + ", isFirstPage=" + isFirstPage + ", isLastPage=" + isLastPage + ", hasPreviousPage="
				+ hasPreviousPage + ", hasNextPage=" + hasNextPage + ", navigatePages=" + navigatePages
				+ ", navigatepageNums=" + Arrays.toString(navigatepageNums) + "]";
	}
    
    
}
