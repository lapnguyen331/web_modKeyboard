import { uuid } from "@/lib/utils";

export const BrandList = () => {
  const brandListImageUrls = [
    "//mkb.gg/cdn/shop/collections/18.png?v=1681472802&width=1500",
   "//mkb.gg/cdn/shop/collections/16.png?v=1681470855&width=1500",
   "//mkb.gg/cdn/shop/collections/29.png?v=1681479662&width=1500",
   "//mkb.gg/cdn/shop/collections/Gateron-logo.webp?v=1685190631&width=1500",
  ];

  return (
    <div className="flex justify-center items-center gap-y-10 gap-x-16 flex-wrap mt-4">
      {brandListImageUrls.map((url) => (
        <div className="max-w-52 max-h-42" key={uuid()}>
          <img className="h-auto max-w-full" src={url} />
        </div>
      ))}
    </div>
  );
};
