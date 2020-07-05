package com.bugever.lychee.web.servlet.system;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.DataSourceParam;
import com.bugever.lychee.util.ParameterizedQuery;
import com.bugever.lychee.web.servlet.Helper;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/system/data-source' -d '{ "id": 0 }'
@WebServlet("/api/system/data-source")
public class DataSource extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, Helper.IdRequest.class, (currentUser, input) -> {
            com.bugever.lychee.domain.DataSource dataSource = new com.bugever.lychee.domain.DataSource();
            if (input.id > 0) {
                ParameterizedQuery query = new ParameterizedQuery(
                        "select id, driver, name, cn_name, remarks, creator_id, created_on" +
                                " from m_data_sources where id = ? and seller_id = ? and deleted = 0",
                        input.id, currentUser.attributes.get(TOKEN_ATTR_SELLER)
                );
                List<com.bugever.lychee.domain.DataSource> list = Database.list(com.bugever.lychee.domain.DataSource.class, query.sql(), query.params());
                if (!list.isEmpty()) {
                    dataSource = list.iterator().next();
                    dataSource.params = Database.list(DataSourceParam.class,
                            "select id, param_name, param_value" +
                                    " from m_data_source_params" +
                                    " where data_source_id = ? and deleted = 0" +
                                    " order by param_name",
                            dataSource.id);
                }
            }
            return dataSource;
        });
    }
}
