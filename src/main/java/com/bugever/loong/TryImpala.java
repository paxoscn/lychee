package com.bugever.loong;

import java.sql.*;

public class TryImpala {

    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Class.forName("com.cloudera.impala.jdbc41.Driver");
        Connection con = DriverManager.getConnection("jdbc:impala://bz-test-bigdata-cdh-02:21050/cdp_ads", "simba", "simba");

        Statement stmt = con.createStatement();

//        stmt.execute("create external TABLE IF NOT EXISTS `ads_tags_mbr_avgpurchaseinterval_d` (\n" +
//                "  `oneid` string,\n" +
//                "  `dim_name` string,\n" +
//                "  `dim_value` string,\n" +
//                "  `avg_purchase_interval_all` int\n" +
//                ")\n" +
//                " STORED AS PARQUET\n" +
//                " location '/data/hive/warehouse/cdp.db/ads_tags_mbr_avgpurchaseinterval_d'");
//
//        ResultSet rs = stmt.executeQuery("show TABLE IF NOT EXISTSs");

        System.out.println("Done");

        long start = System.currentTimeMillis();

//        ResultSet rs = stmt.executeQuery("select\n" +
//                "    '20200803',\n" +
//                "    '20200809',\n" +
//                "    t.tag,\n" +
//                "    count(distinct t.oneid),\n" +
//                "    sum(coalesce(ss.purchase_amount, 0)),\n" +
//                "    sum(if(cast(coalesce(ss.purchase_count, 0) - coalesce(ss_start.purchase_count, 0) as DECIMAL) <= 0, 0, 1)),\n" +
//                "    sum(if(cast(coalesce(ss.purchase_count, 0) - coalesce(ss_start.purchase_count, 0) as DECIMAL) <= 0, 0, coalesce(ss.purchase_amount, 0) - coalesce(ss_start.purchase_amount, 0))),\n" +
//                "    sum(if(cast(coalesce(ss.purchase_count, 0) - coalesce(ss_start.purchase_count, 0) as DECIMAL) <= 0, 0, coalesce(ss.purchase_amount, 0) - coalesce(ss_start.purchase_amount, 0))) / (sum(if(cast(coalesce(ss.purchase_count, 0) - coalesce(ss_start.purchase_count, 0) as DECIMAL) <= 0, 0, coalesce(ss.purchase_count, 0) - coalesce(ss_start.purchase_count, 0))) + 0.0000000000001),\n" +
//                "    '1001'\n" +
//                "from\n" +
//                "    (select distinct oneid, tag from (\n" +
//                "        select oneid, 'ALL' tag from dw_member_oneid\n" +
//                "        union all\n" +
//                "        select\n" +
//                "            oneid,\n" +
//                "            case customer_lifecycle_stage when '0' then 'EXPOSURE_NOPAY' when '1' then 'INTERACTIVE_NOPAY' when '2' then 'JOIN_NOPAY' when '3' then 'FIRST_PAY' when '4' then 'AFTER_PAY' when '5' then 'ACTIVE' when '6' then 'SLEEP' when '7' then 'LOSS' else 'THOROUGH_LOSS_PRO' end tag\n" +
//                "        from\n" +
//                "            ads_tags_mbr_customerlifecyclestage_d_ds t1\n" +
//                "        where ds = '20200731' and customer_lifecycle_stage is not null \n" +
//                "        union all\n" +
//                "        select\n" +
//                "            oneid,\n" +
//                "            case membership_level when '0' then 'V5' when '1' then 'V4' when '2' then 'V3' when '3' then 'V2' else 'V1' end tag\n" +
//                "        from\n" +
//                "            tags_mbr_membershiplevel_d_ds t2\n" +
//                "        where ds = '20200731' \n" +
//                "        union all\n" +
//                "        select\n" +
//                "            oneid,\n" +
//                "            case customer_intimacy when '0' then 'P' when '1' then 'IP' when '2' then 'MP' when '3' then 'FP' else 'NP' end tag\n" +
//                "        from\n" +
//                "            tags_mbr_customerintimacy_d_ds t3\n" +
//                "        where ds = '20200731' \n" +
//                "    ) t) t\n" +
//                "    left join\n" +
//                "    (select oneid, sum(purchase_count) purchase_count, sum(purchase_amount) purchase_amount from dw_sum_stats_fact ss where sum_date = '20200809' group by oneid) ss\n" +
//                "on\n" +
//                "    ss.oneid = t.oneid\n" +
//                "left join\n" +
//                "    (select oneid, sum(purchase_count) purchase_count, sum(purchase_amount) purchase_amount from dw_sum_stats_fact where sum_date = '20200802' group by oneid) ss_start\n" +
//                "on\n" +
//                "    ss.oneid = ss_start.oneid \n" +
//                "where\n" +
//                "    1 = 1\n" +
//                "group by\n" +
//                "    t.tag");

//        ResultSet rs = stmt.executeQuery("select count(d.oneid) from ads_tags_mbr_CustomerBasicInfo_d d left join (SELECT DISTINCT ONEID FROM ADS_TAGS_MBR_CUSTOMERBASICINFO_D WHERE GENDER = '2') a on d.oneid = a.oneid where a.oneid is not null\n");

//        ResultSet rs = stmt.executeQuery("select count(d.oneid) from ads_tags_mbr_CustomerBasicInfo_d d left join ( SELECT DISTINCT A.ONEID FROM (  SELECT B.ONEID FROM ( SELECT DISTINCT A.ONEID FROM (SELECT DISTINCT ONEID FROM ADS_TAGS_MBR_CUSTOMERBASICINFO_D WHERE GENDER = '2' ) A  UNION ALL SELECT DISTINCT ONEID FROM ADS_TAGS_MBR_CUSTOMERLIFECYCLESTAGE_D WHERE customer_lifecycle_stage ='3'  ) B GROUP BY B.ONEID HAVING COUNT(*) > 1 ) A ) a on d.oneid = a.oneid where a.oneid is not null\n");

//        ResultSet rs = stmt.executeQuery("select count(d.oneid) from ads_tags_mbr_CustomerBasicInfo_d d left join ( SELECT DISTINCT A.ONEID FROM ( SELECT DISTINCT A.ONEID FROM (SELECT DISTINCT ONEID FROM ADS_TAGS_MBR_CUSTOMERBASICINFO_D WHERE GENDER = '2' ) A  UNION SELECT DISTINCT ONEID FROM ADS_TAGS_MBR_CUSTOMERLIFECYCLESTAGE_D WHERE customer_lifecycle_stage ='3'  ) A ) a on d.oneid = a.oneid where a.oneid is not null\n");

        ResultSet rs = stmt.executeQuery("select * from dw_member_oneid where ONEID = 'e3_member_id#100100100102102150200149106199157105149152101200'\n");

        String ths = "";
        for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
            ths += rs.getMetaData().getColumnName(i) + " | ";
        }
        System.out.println(ths);
        while (rs.next()) {
            String tds = "";
            for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                tds += rs.getObject(i) + " | ";
            }
            System.out.println(tds);
        }

        System.out.println(System.currentTimeMillis() - start);

        con.close();
    }
}
