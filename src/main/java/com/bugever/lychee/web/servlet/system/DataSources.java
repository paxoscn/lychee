package com.bugever.lychee.web.servlet.system;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.DataSource;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/system/data-sources' -d '{}'
@WebServlet("/api/system/data-sources")
public class DataSources extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, (currentUser) -> Database.list(DataSource.class,
                "select id, driver, name, cn_name, remarks," +
                        " creator_id, created_on from m_data_sources where seller_id = ? and deleted = 0" +
                        " order by name",
                currentUser.attributes.get(TOKEN_ATTR_SELLER)));
    }
}
