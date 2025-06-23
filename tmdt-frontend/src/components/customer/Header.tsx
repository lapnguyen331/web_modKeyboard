import { Badge } from "@/components/ui/badge";
import {
  NavigationMenu,
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  NavigationMenuTrigger,
} from "@/components/ui/navigation-menu";
import {
  Heart,
  Lock,
  LogOut,
  Search,
  ShoppingCart,
  User,
  User2,
} from "lucide-react";
import { Link, Route, useNavigate } from "react-router-dom";
import { Input } from "../ui/input";
import { Popover, PopoverContent, PopoverTrigger } from "../ui/popover";
import { useDispatch, useSelector } from "react-redux";
import { RootState } from "@/redux/store.ts";
import { ROUTES } from "@/types/constant.ts";
import { useLogoutMutation } from "@/api/auth.ts";
import { setCurrentUser } from "@/redux/slices/authSlice.ts";
import { cn, toastError, toastSuccess } from "@/lib/utils.ts";
import { useCountTotalQuantitiesQuery } from "@/api/customerApi/cart.ts";
import { useEffect } from "react";
import { setTotalQuantities } from "@/redux/slices/cartSlice.ts";
import { useState } from "react";
import { useStickyHeader } from "@/hooks/useStickyHeader";
import { useGetCategoriesQuery } from "@/api/customerApi/category";

export const NavBar = () => {
  const { data } = useGetCategoriesQuery();

  return (
    <NavigationMenu className="my-4 mx-auto header-sec">
      <NavigationMenuList>
          <li style={{padding:'0 100px 0 0'}}>
                 <div
          // onClick={() => navigate(ROUTES.HOME)}
          className="">
           <img
      src="src\assets\l1.png"
      alt="Logo"
      className=""
    />
        </div>
          </li>
        <NavigationMenuItem className="font-bold border-b-2 pr-4 border-b-primary">
          <Link to="/">Trang chủ</Link>
        </NavigationMenuItem>
        <NavigationMenuItem>
          <NavigationMenuTrigger className="bg-transparent ml-24 ">
            Sản phẩm
          </NavigationMenuTrigger>
          <NavigationMenuContent>
            <ul className="grid gap-1  w-[200px] ">
              
              {data &&
                data.length > 0 &&
                data?.map((category) => (
                  <li
                    key={category.id}
                    className="border-b-1 border-b-gray-200"
                  >
                    <NavigationMenuLink>{category.name}</NavigationMenuLink>
                  </li>
                ))}
            </ul>
          </NavigationMenuContent>
        </NavigationMenuItem>
        <NavigationMenuItem className="ml-24">
          <Link to={ROUTES.WISHLIST}>Danh sách yêu thích</Link>
        </NavigationMenuItem>
        <NavigationMenuItem className="ml-24">
          <Link to={ROUTES.HOME}>Tư vấn</Link>
        </NavigationMenuItem>
      </NavigationMenuList>
    </NavigationMenu>
  );
};
interface SearchBarProps {
  className?: string;
  placeholder?: string;
  initialValue?: string;
  onSearch?: (value: string) => void;
}
const SearchBar = ({
  className = "",
  placeholder = "Tìm kiếm sản phẩm...",
  initialValue = "",
  onSearch,
}: SearchBarProps) => {
  const [searchTerm, setSearchTerm] = useState(initialValue);
  const navigate = useNavigate();

  const handleSearch = () => {
    if (onSearch) {
      onSearch(searchTerm);
    } else {
      // Nếu không có hàm onSearch được truyền vào, chuyển hướng đến trang tìm kiếm
      navigate(`/tim-kiem?q=${encodeURIComponent(searchTerm)}`);
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === "Enter") {
      handleSearch();
    }
  };

  return (
    <div
      className={`relative drop-shadow-md rounded-lg border border-white-200 text-white ${className}`}
    >
      <Input
        className="rounded-lg border-none ring-0 pl-4 pr-10 py-2 text-white placeholder-white"
        placeholder={placeholder}
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        onKeyDown={handleKeyDown}
      />
      <button
        onClick={handleSearch}
        className="absolute top-1/2 transform -translate-y-1/2 right-3 text-white-400 hover:text-white transition-colors"
      >
        <Search size={20} />
      </button>
    </div>
  );
};
export const Header = () => {
  const { me } = useSelector((state: RootState) => state.auth);
  const [logout] = useLogoutMutation();
  const navigate = useNavigate();

  const { data, isLoading } = useCountTotalQuantitiesQuery();
  const dispatch = useDispatch();
  const { totalQuantities } = useSelector((state: RootState) => state.cart);
  const wishlist = useSelector((state: RootState) => state.wishlist);

  useEffect(() => {
    const quantityResp = data?.data;
    if (quantityResp !== undefined && !isLoading) {
      dispatch(setTotalQuantities(quantityResp));
    }
  }, [data, isLoading, dispatch]);
  const isSticky = useStickyHeader();
  const handleLogout = async () => {
    try {
      await logout();

      // Cập nhật user vào Redux
      dispatch(setCurrentUser(null));
      toastSuccess("Đăng xuất thành công");
      navigate(ROUTES.HOME);
    } catch (error) {
      toastError("Đăng xuất thất bại", 2000);
    }
  };
  const handleNavigate =() => {
    console.log("tới cus")
    navigate(ROUTES.KEYBOARDBUIDER)
  }

  return (
    <div
      className={cn(
        " z-10 bg-new-blue transition-all ease-in-out duration-400",
        isSticky ? "sticky top-0" : "top-[-100px]",
      )}
    >
      <div className="flex justify-between items-center px-16 py-2 text-white ">
        <div className="" style={{border:"2px solid black",padding:"5px 10px",backgroundColor:"#0787b9"}}>
          <button
          onClick={handleNavigate}
          >Đặt hàng theo yêu cầu</button>
        </div>
        <SearchBar />
        <div className="flex-center gap-10">
          <Popover>
            <PopoverTrigger className="cursor-pointer">
              <User />
            </PopoverTrigger>
            <PopoverContent className="w-42  " sideOffset={9}>
              {me ? (
                <button
                  className="flex gap-4 hover:text-red-900 cursor-pointer"
                  onClick={handleLogout}
                >
                  <LogOut />
                  Đăng xuất
                </button>
              ) : (
                <>
                  <Link
                    to={ROUTES.LOGIN}
                    className="flex gap-4 mb-4 hover:text-red-900"
                  >
                    <Lock />
                    Đăng nhập
                  </Link>
                  <Link
                    to={ROUTES.REGISTER}
                    className="flex gap-4  hover:text-red-900"
                  >
                    <User2 />
                    Đăng ký
                  </Link>
                </>
              )}
            </PopoverContent>
          </Popover>
              
              <div className="flex-center gap-10">
            {me ?(
     

              <Link to={ROUTES.CART} className="flex gap-4  hover:text-red-900">
                  <ShoppingCart />
              </Link>
 
            ):<p></p>}
            </div>
            
            
        </div>
      </div>
    </div>
  );
};
