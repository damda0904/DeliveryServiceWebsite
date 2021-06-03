import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Scanner;

public class CancelOrder {
    public CancelOrder() {
        Scanner sc = new Scanner(System.in);
        int onum = 0;

        System.out.println("");
        System.out.println("취소할 주문 번호를 입력하세요");
        onum = sc.nextInt();

        cancel(onum);
    }


    //주문 삭제
   public void cancel(int onum) {
        Connection conn = null;
        Statement str = null;
        ResultSet rs = null;

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
        try {
            String URL = "jdbc:mysql://localhost:3305/homework?serverTimezone=UTC";
            conn = DriverManager.getConnection(URL, "root", "123456");
        } catch (Exception e) {
            System.out.println("DB 서버 접속을 실패하였습니다.");
            System.out.println("");
            System.out.println(e);
        }

        //3단계 : 레코드가 존재하는지 검색
        try {
            str = conn.createStatement();
            rs = str.executeQuery("select onum from orders where onum = " + onum);

            while (rs.next()) {
                int onum_ = Integer.parseInt(rs.getString("onum"));
                if (onum != onum_) {
                    System.out.println("해당 주문번호가 존재하지 않습니다.");
                    return;
                }
            }

            rs.close();
        } catch (Exception e) {
            System.out.println("onum을 검색할 수 없습니다.");
            System.out.println("");
            System.out.println(e);
        }

        //4단계 : 레코드 삭제
        try {
            str.executeUpdate("delete from orders where onum = " + onum);

            System.out.println("성공적으로 삭제하였습니다.");

        } catch (Exception e) {
            System.out.println("레코드를 삭제할 수 없습니다.");
            System.out.println("");
            System.out.println(e);
        }
    }
}
