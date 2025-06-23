import { Button } from "@/components/ui/button";
import { Card, CardDescription, CardFooter } from "@/components/ui/card";
import { Link } from "react-router-dom";
import { useGetNewestProductsQuery } from "@/api/customerApi/product.ts";
import Loader from "@/components/ui/Loader.tsx";
import { ProductSummaryResponse } from "@/types/product.ts";

const CollectionCard: React.FC<ProductSummaryResponse> = (product) => {
  const cutOffDescription = (description: string) => {
    if (!description) return "";

    const arr = description.split(" ");
    if (arr.length <= 30) return description;

    return arr.slice(0, 30).join(" ") + "...";
  };

  return (
    <Card className="p-0 shadow gap-2 group hover:shadow-2xl transition-shadow">
      <div className="rounded-2xl overflow-hidden">
        <div className="overflow-hidden">
          <img
            className="group-hover:scale-120 transition-transform"
            src={product.thumbnail}
            alt={product.name}
          />
        </div>
      </div>
      <CardDescription className="px-4 m-0">
        <h3>{product.name}</h3>
      </CardDescription>
      <CardFooter className="mb-3 px-4 ">
        <Link to={"/collection/" + product.id}>
          <Button>Khám phá ngay</Button>
        </Link>
      </CardFooter>
    </Card>
  );
};

export const NewCollection = () => {
  const { data, isLoading } = useGetNewestProductsQuery({ page: 1, size: 3 });

  const renderProducts = () => {
    if (isLoading) {
      return <Loader />;
    }

    const products = data?.data;
    if (!products || products.length === 0) {
      return (
        <p className="text-center w-full m-3 text-xl">Không có sản phẩm nào</p>
      );
    }

    return (
      <div className="grid grid-cols-3 gap-10 mt-6">
        {products.map((product) => (
          <CollectionCard key={product.id} {...product} />
        ))}
      </div>
    );
  };

  return (
    <div className="my-4">
      <div className="w-1/2 mx-auto">
        <h1 className="text-center">Bộ sưu tập mới</h1>
        <p className="text-center text-gray">
          Bộ sưu tập mới của
          <strong> Mod Keyboard </strong>
          Bộ sưu tập mới từ Mod Keyboard mang đến những mẫu bàn phím cơ cao cấp với thiết kế tinh xảo và cảm giác gõ mượt mà. Mỗi sản phẩm là sự kết hợp hoàn hảo giữa hiệu năng và thẩm mỹ, được tuyển chọn kỹ lưỡng để nâng tầm trải nghiệm gõ phím của bạn.
        </p>
      </div>

      {renderProducts()}
    </div>
  );
};
