package com.bugever.lychee.web.servlet.modeling;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.util.ParameterizedQuery;
import com.bugever.lychee.web.servlet.Helper;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;

// curl 'http://127.0.0.1:8080/api/modeling/dimension' -d '{ "id": 0 }'
@WebServlet("/api/modeling/dimension")
public class Dimension extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, Helper.IdRequest.class, (currentUser, input) -> {
            com.bugever.lychee.domain.Dimension dimension = new com.bugever.lychee.domain.Dimension();
            if (input.id > 0) {
                ParameterizedQuery query = new ParameterizedQuery(
                        "select id, name, cn_name, remarks, identity_id," +
                                " data_type, desensitization_method, creator_id, created_on" +
                                " from m_dimensions where id = ? and seller_id = ? and deleted = 0",
                        input.id, currentUser.attributes.get(TOKEN_ATTR_SELLER)
                );
                List<com.bugever.lychee.domain.Dimension> list = Database.list(com.bugever.lychee.domain.Dimension.class, query.sql(), query.params());
                if (!list.isEmpty()) {
                    dimension = list.iterator().next();
                }
            }
            return dimension;
        });
    }
}
