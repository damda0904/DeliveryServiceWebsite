import java.util.Scanner;

public class MainMenu {
    public static void main(String[] args) {
        boolean choice = true;

        do {
            System.out.println("");
            System.out.println("메뉴를 선택하세요");
            System.out.println("1) 소비자 메뉴");
            System.out.println("2) 오너 로그인");
            System.out.println("3) 배달원 로그인");
            System.out.println("4) 끝내기");

            Scanner sc = new Scanner(System.in);

            int num = sc.nextInt();

            switch(num) {
                case 1:
                    new CustomerMenu();
                    break;
                case 2:
                    new OwnerMenu();
                    break;
                case 3:
                    new DeliveryManMenu();
                    break;
                case 4:
                    choice = false;
                    break;
                default:
                    System.out.println("번호를 확인해주세요.");
            }
        } while(choice);

        System.out.println("");
        System.out.println("안녕히 가세요~");

        return;
    }
}
