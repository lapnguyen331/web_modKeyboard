import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel";
import { uuid } from "@/lib/utils";
import Autoplay from "embla-carousel-autoplay";
import { useState } from "react";

export const Banner = () => {
  const bannerUrl = [
    "src/assets/b1.png",
    "src/assets/b2.webp",
    "src/assets/b3.webp",
  ];
  const [autoplay] = useState(() =>
    Autoplay({ delay: 3000, stopOnInteraction: false }),
  );
  return (
    <div className="w-full  ">
      <Carousel plugins={[autoplay]}>
        <CarouselContent>
          {bannerUrl.map((url) => (
            <CarouselItem key={uuid()}>
              <div className="h-[520px] w-full rounded-3xl overflow-hidden">
                <img className="w-full object-fit h-full" src={url} />
              </div>
            </CarouselItem>
          ))}
        </CarouselContent>
        <CarouselPrevious />
        <CarouselNext />
      </Carousel>
    </div>
  );
};
