import java.sql.*;

public class ShowOrders {
    public ShowOrders(int rnum) {
        fetchRecords(rnum);
    }


    //해당 식당의 매출 리스트 출력
    public void fetchRecords(int rnum) {
        Connection conn = null;
        Statement str = null;
        ResultSet rs = null;

        int total = 0;
        int records = 0;
        String name = null;
        int count = 0;
        int price = 0;

        //1단계
        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("");
        } catch (Exception e) {
            System.out.println("MySQL JDBC Driver 로딩을 실패하였습니다.");
            System.out.println("");
            System.out.println(e);
        }

        //2단계
        try{
            String URL = "jdbc:mysql://localhost:3305/homework?serverTimezone=UTC";
            conn = DriverManager.getConnection(URL, "root", "123456");
        } catch(Exception e) {
            System.out.println("DB 서버 접속을 실패하였습니다.");
            System.out.println("");
            System.out.println(e);
        }

        //3단계 : 리스트 검색 및 출력
        try{
            str = conn.createStatement();
            rs = str.executeQuery("select * from orders o, food f where o.fnum = f.fnum and o.rnum = " + rnum);

            System.out.println("");
            System.out.println("===============================");
            System.out.println("메뉴명 | 수량 | 결제금액");
            System.out.println("-------------------------------");
            while(rs.next()){
                name = rs.getString("f.name");
                count = Integer.parseInt(rs.getString("o.count"));
                price = Integer.parseInt(rs.getString("o.price"));
                System.out.println(name + " | " + count + " | " + price);
                total += price;
                records++;
            }
            System.out.println("===============================");
            System.out.println("총 주문 개수 : " + records);
            System.out.println("총 매출액 : " + total);

            rs.close();
            str.close();
            conn.close();
        } catch (Exception e) {
            System.out.println("목록을 가져오는데 실패했습니다.");
            System.out.println(e);
        }
    }
}
