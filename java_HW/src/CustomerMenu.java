import java.sql.*;
import java.util.ArrayList;
import java.util.Scanner;

public class CustomerMenu {
    public CustomerMenu() {
        Scanner sc = new Scanner(System.in);
        int num = 0;
        boolean loop = true;

        while(loop) {
            System.out.println("");
            System.out.println("메뉴를 선택하세요");
            System.out.println("1) 주문하기");
            System.out.println("2) 주문 취소하기");
            System.out.println("3) 뒤로가기");

            num = sc.nextInt();

            switch(num) {
                case 1:
                    new Order();
                    break;
                case 2:
                    new CancelOrder();
                    break;
                case 3:
                    loop = false;
                    break;
                default:
                    System.out.println("번호를 확인해 주세요");
            }
        }

    }
}
