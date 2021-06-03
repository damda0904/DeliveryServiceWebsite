import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class OrderResult {
    Connection conn = null;
    Statement str = null;
    ResultSet info = null;


    public OrderResult(int fnum, int count) {
        getInfo(fnum);
        insert(fnum, count);
    }


    //메뉴, 식당 정보 가져오기
    public void getInfo(int fnum) {
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

        //3단계
        try {
            str = conn.createStatement();

            String query = "select * from food f, restaurant r where f.rnum = r.rnum and f.fnum = " + fnum;
            info = str.executeQuery(query);
        } catch (Exception e) {
            System.out.println("테이블의 전체 데이터 검색을 실패하였습니다.");
        }
    }


    //주문 추가
    public void insert(int fnum, int count) {
        ResultSet result = null;
        int rs = 0;

        int totalPrice = 0;
        String query = null;

        //쿼리 설정
        try {
            while (info.next()) {
                totalPrice = Integer.parseInt(info.getString("price")) * count;
                String place = info.getString("r.place");
                int rnum = Integer.parseInt(info.getString("r.rnum"));
                query = "insert into orders(rnum, count, location, price, fnum) " +
                        "values (" + rnum + ", " + count + ", \"" + place + "\", " + totalPrice + ", " + fnum + ")";
//                System.out.println(query);
            }
        } catch (Exception e){
            System.out.println("info.next()에 실패했습니다.");
            System.out.println(e);
        }

        //삽입
        try{
            rs = str.executeUpdate(query);

            if(rs>0) {
                System.out.println("성공적으로 주문되었습니다.");
            } else {
                System.out.println("데이터 삽입에 실패했습니다.");
            }
        } catch (Exception e){
            System.out.println("insert 쿼리를 실패했습니다.");
            System.out.println(e);
        }

        //확인용
        try{
            result = str.executeQuery("select * from orders order by onum DESC limit 1");

            while(result.next()){
                System.out.print(result.getString("onum") + ", ");
                System.out.print(result.getString("fnum") + ", ");
                System.out.print(result.getString("price") + ", ");
                System.out.println(result.getString("count"));
            }
        } catch (Exception e){
            System.out.println("데이터를 가져오지 못했습니다.");
            System.out.println(e);
        }


    }
}
