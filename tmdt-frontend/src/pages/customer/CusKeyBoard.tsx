// import { useState } from "react";
// import { Button } from "@/components/ui/button";
// import { Card, CardContent } from "@/components/ui/card";
// import { Checkbox } from "@/components/ui/checkbox";
// import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";

// const layoutOptions = [
//   { label: "Fullsize", value: "fullsize", price: 0, imgURL:"src/assets/custom/96percent_338adbfb-b9dc-4927-ac9e-2ec9e8f36f4c.svg" },
//   { label: "TKL", value: "tkl", price: -10, imgURL:"src/assets/custom/tkl.svg" },
//   { label: "75%", value: "75", price: -15 , imgURL:"src/assets/custom/75.svg"},
//   { label: "60%", value: "60", price: -20 , imgURL:"src/assets/custom/60.svg"},
// ];

// const switchOptions = [
//   { label: "Gateron Red - Linear", value: "Gateron Red", price: 120000, imgURL: "src/assets/custom/1.webp" },
//   { label: "Gateron Brown - Tactile", value: "Gateron Brown", price: 125000, imgURL: "src/assets/custom/2.webp" },
//   { label: "Gateron Blue - Clicky", value: "Gateron Blue", price: 130000, imgURL: "src/assets/custom/3.webp" },
//   { label: "Kailh Box White - Clicky", value: "Kailh Box White", price: 150000, imgURL: "src/assets/custom/4.webp" },
//   { label: "Kailh Box Red - Linear", value: "Kailh Box Red", price: 145000, imgURL: "src/assets/custom/5.webp" },
//   { label: "Cherry MX Red - Linear", value: "Cherry MX Red", price: 180000, imgURL: "src/assets/custom/6.webp" },
//   { label: "Cherry MX Brown - Tactile", value: "Cherry MX Brown", price: 185000, imgURL: "src/assets/custom/7.webp" },
//   { label: "Cherry MX Blue - Clicky", value: "Cherry MX Blue", price: 190000, imgURL: "src/assets/custom/8.webp" },
//   { label: "Akko CS Lavender Purple - Tactile", value: "Akko CS Lavender Purple", price: 160000, imgURL: "src/assets/custom/9.webp" },
//   { label: "Akko CS Jelly Black - Linear", value: "Akko CS Jelly Black", price: 155000, imgURL: "src/assets/custom/10.webp" },
//   { label: "Akko CS Silver - Linear", value: "Akko CS Silver", price: 165000, imgURL: "src/assets/custom/11.webp" },
//   { label: "TTC Gold Pink - Linear", value: "TTC Gold Pink", price: 175000, imgURL: "src/assets/custom/12.webp" },
//   { label: "TTC Bluish White - Tactile", value: "TTC Bluish White", price: 170000, imgURL: "src/assets/custom/13.webp" },
//   { label: "Zealios V2 - Tactile", value: "Zealios V2", price: 240000, imgURL: "src/assets/custom/14.webp" },
// ];

// const BAREBONESKITOption = [
//   { label: "Keychron Q1 V2 - Aluminium", value: "Keychron Q1 V2", price: 2600000, imgURL: "src/assets/custom/b1.webp" },
//   { label: "Monsgeek M1 - Aluminium CNC", value: "Monsgeek M1", price: 2200000, imgURL: "src/assets/custom/b2.webp" },
//   { label: "Akko MOD007 V2 - South-facing", value: "Akko MOD007 V2", price: 2400000, imgURL: "src/assets/custom/b3.webp" },
//   { label: "Meletrix Zoom65 Essential Edition - Wireless", value: "Meletrix Zoom65 EE", price: 3200000, imgURL: "src/assets/custom/b4.webp" }
// ];
// const KEYCAPOption = [
//      { label: "Cherry Profile - GMK Red Samurai", value: "GMK Red Samurai", price: 1800000, imgURL: "src/assets/custom/k1.webp" },
//   { label: "XDA Profile - Akko Neon Keycap Set", value: "Akko Neon", price: 850000, imgURL: "src/assets/custom/k2.webp" },
//   { label: "OEM Profile - Tai-Hao Sunshine PBT", value: "Tai-Hao Sunshine", price: 690000, imgURL: "src/assets/custom/k3.webp" },
//   { label: "SA Profile - Domikey Retro Keycap Set", value: "Domikey Retro", price: 2200000, imgURL: "src/assets/custom/k4.webp" },
//   { label: "Cherry Profile - ePBT Grand Tour", value: "ePBT Grand Tour", price: 1450000, imgURL: "src/assets/custom/k5.webp" },
//   { label: "DSA Profile - Blank PBT Keycaps", value: "Blank PBT", price: 390000, imgURL: "src/assets/custom/k6.webp" },
//   { label: "OEM Profile - HyperX Pudding Keycaps", value: "HyperX Pudding", price: 550000, imgURL: "src/assets/custom/k7.webp" },
//   { label: "ASA Profile - Akko World Tour Tokyo", value: "Akko Tokyo", price: 880000, imgURL: "src/assets/custom/k8.webp" },
//   { label: "SA Profile - MiTo Laser", value: "MiTo Laser", price: 2100000, imgURL: "src/assets/custom/k9.webp" },
//   { label: "Cherry Profile - GMK Olivia++", value: "GMK Olivia++", price: 2500000, imgURL: "src/assets/custom/k10.webp" }
// ]

// export const CusKeyBoard = () =>{
// //   const [selectedLayout, setSelectedLayout] = useState("fullsize");
// //   const [selectedSwitch, setSelectedSwitch] = useState("linear");
// //   const [selectedStabilizer, setSelectedStabilizer] = useState("stock");

// //   const layoutPrice = layoutOptions.find((l) => l.value === selectedLayout)?.price || 0;
// //   const totalPrice = 150 + layoutPrice; // base price + layout modifier

//   return (
//     <div className="max-w-3xl mx-auto mt-10 p-6 space-y-6">
//       <h1 className="text-4xl font-semibold text-center">Tùy chỉnh bàn phím</h1>

//       <Card>
//         <CardContent className="pt-6 space-y-4">
//           <div>
//             <h2 className="text-xl font-medium mb-2">Chọn Layout</h2>
//             <RadioGroup
//               value={selectedLayout}
//               onValueChange={setSelectedLayout}
//               className="grid grid-cols-2 gap-4"
//             >
//               {layoutOptions.map((option) => (
//                 <RadioGroupItem key={option.value} value={option.value} className="flex items-center gap-2">
//                   <span>{option.label} {option.price !== 0 && `(+${option.price}$)`}</span>
//                 </RadioGroupItem>
//               ))}
//             </RadioGroup>
//           </div>

//           <div>
//             <h2 className="text-xl font-medium mb-2">Chọn Switch</h2>
//             <RadioGroup
//               value={selectedSwitch}
//               onValueChange={setSelectedSwitch}
//               className="flex gap-4"
//             >
//               {switchOptions.map((option) => (
//                 <RadioGroupItem key={option.value} value={option.value} className="flex items-center gap-2">
//                   <span>{option.label}</span>
//                 </RadioGroupItem>
//               ))}
//             </RadioGroup>
//           </div>

//           <div>
//             <h2 className="text-xl font-medium mb-2">Chọn Stabilizer</h2>
//             <RadioGroup
//               value={selectedStabilizer}
//               onValueChange={setSelectedStabilizer}
//               className="flex gap-4"
//             >
//               {stabilizerOptions.map((option) => (
//                 <RadioGroupItem key={option.value} value={option.value} className="flex items-center gap-2">
//                   <span>{option.label}</span>
//                 </RadioGroupItem>
//               ))}
//             </RadioGroup>
//           </div>

//           <div className="text-right text-lg font-semibold">
//             Tổng giá: <span className="text-primary">${totalPrice}</span>
//           </div>

//           <Button className="w-full">Thêm vào giỏ hàng</Button>
//         </CardContent>
//       </Card>
//     </div>
//   );
// }


import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";

const layoutOptions = [
  { label: "Fullsize", value: "fullsize", price: 0, imgURL:"src/assets/custom/96percent_338adbfb-b9dc-4927-ac9e-2ec9e8f36f4c.svg" },
  { label: "TKL", value: "tkl", price: -10, imgURL:"src/assets/custom/tkl.svg" },
  { label: "75%", value: "75", price: -15 , imgURL:"src/assets/custom/75.svg"},
  { label: "60%", value: "60", price: -20 , imgURL:"src/assets/custom/60.svg"},
];

const switchOptions = [
  { label: "Gateron Red - Linear", value: "Gateron Red", price: 120000, imgURL: "src/assets/custom/1.webp" },
  { label: "Gateron Brown - Tactile", value: "Gateron Brown", price: 125000, imgURL: "src/assets/custom/2.webp" },
  { label: "Gateron Blue - Clicky", value: "Gateron Blue", price: 130000, imgURL: "src/assets/custom/3.webp" },
  { label: "Kailh Box White - Clicky", value: "Kailh Box White", price: 150000, imgURL: "src/assets/custom/4.webp" },
  { label: "Kailh Box Red - Linear", value: "Kailh Box Red", price: 145000, imgURL: "src/assets/custom/5.webp" },
  { label: "Cherry MX Red - Linear", value: "Cherry MX Red", price: 180000, imgURL: "src/assets/custom/6.webp" },
  { label: "Cherry MX Brown - Tactile", value: "Cherry MX Brown", price: 185000, imgURL: "src/assets/custom/7.webp" },
  { label: "Cherry MX Blue - Clicky", value: "Cherry MX Blue", price: 190000, imgURL: "src/assets/custom/8.webp" },
  { label: "Akko CS Lavender Purple - Tactile", value: "Akko CS Lavender Purple", price: 160000, imgURL: "src/assets/custom/9.webp" },
  { label: "Akko CS Jelly Black - Linear", value: "Akko CS Jelly Black", price: 155000, imgURL: "src/assets/custom/10.webp" },
  { label: "Akko CS Silver - Linear", value: "Akko CS Silver", price: 165000, imgURL: "src/assets/custom/11.webp" },
  { label: "TTC Gold Pink - Linear", value: "TTC Gold Pink", price: 175000, imgURL: "src/assets/custom/12.webp" },
  { label: "TTC Bluish White - Tactile", value: "TTC Bluish White", price: 170000, imgURL: "src/assets/custom/13.webp" },
  { label: "Zealios V2 - Tactile", value: "Zealios V2", price: 240000, imgURL: "src/assets/custom/14.webp" },
];

const BAREBONESKITOption = [
  { label: "Keychron Q1 V2 - Aluminium", value: "Keychron Q1 V2", price: 2600000, imgURL: "src/assets/custom/b1.webp" },
  { label: "Monsgeek M1 - Aluminium CNC", value: "Monsgeek M1", price: 2200000, imgURL: "src/assets/custom/b2.webp" },
  { label: "Akko MOD007 V2 - South-facing", value: "Akko MOD007 V2", price: 2400000, imgURL: "src/assets/custom/b3.webp" },
  { label: "Meletrix Zoom65 Essential Edition - Wireless", value: "Meletrix Zoom65 EE", price: 3200000, imgURL: "src/assets/custom/b4.webp" }
];
const KEYCAPOption = [
     { label: "Cherry Profile - GMK Red Samurai", value: "GMK Red Samurai", price: 1800000, imgURL: "src/assets/custom/k1.webp" },
  { label: "XDA Profile - Akko Neon Keycap Set", value: "Akko Neon", price: 850000, imgURL: "src/assets/custom/k2.webp" },
  { label: "OEM Profile - Tai-Hao Sunshine PBT", value: "Tai-Hao Sunshine", price: 690000, imgURL: "src/assets/custom/k3.webp" },
  { label: "SA Profile - Domikey Retro Keycap Set", value: "Domikey Retro", price: 2200000, imgURL: "src/assets/custom/k4.webp" },
  { label: "Cherry Profile - ePBT Grand Tour", value: "ePBT Grand Tour", price: 1450000, imgURL: "src/assets/custom/k5.webp" },
  { label: "DSA Profile - Blank PBT Keycaps", value: "Blank PBT", price: 390000, imgURL: "src/assets/custom/k6.webp" },
  { label: "OEM Profile - HyperX Pudding Keycaps", value: "HyperX Pudding", price: 550000, imgURL: "src/assets/custom/k7.webp" },
  { label: "ASA Profile - Akko World Tour Tokyo", value: "Akko Tokyo", price: 880000, imgURL: "src/assets/custom/k8.webp" },
  { label: "SA Profile - MiTo Laser", value: "MiTo Laser", price: 2100000, imgURL: "src/assets/custom/k9.webp" },
  { label: "Cherry Profile - GMK Olivia++", value: "GMK Olivia++", price: 2500000, imgURL: "src/assets/custom/k10.webp" }
]

export const CusKeyBoard = () => {
  const [selectedLayout, setSelectedLayout] = useState(layoutOptions[0].value);
  const [selectedSwitch, setSelectedSwitch] = useState(switchOptions[0].value);
  const [selectedBarebone, setSelectedBarebone] = useState(BAREBONESKITOption[0].value);
  const [selectedKeycap, setSelectedKeycap] = useState(KEYCAPOption[0].value);

  const getPrice = (options, selected) =>
    options.find((item) => item.value === selected)?.price || 0;

  const totalPrice =
    getPrice(layoutOptions, selectedLayout) +
    getPrice(switchOptions, selectedSwitch) +
    getPrice(BAREBONESKITOption, selectedBarebone) +
    getPrice(KEYCAPOption, selectedKeycap);

  return (
    <div className="max-w-5xl mx-auto pb-32 px-4">
      <h1 className="text-4xl font-semibold text-center my-6">Tùy chỉnh bàn phím</h1>

      <Card>
        <CardContent className="py-6 space-y-10">
          {[
            { title: "Chọn Layout", options: layoutOptions, selected: selectedLayout, setSelected: setSelectedLayout },
            { title: "Chọn Switch", options: switchOptions, selected: selectedSwitch, setSelected: setSelectedSwitch },
            { title: "Chọn Barebones Kit", options: BAREBONESKITOption, selected: selectedBarebone, setSelected: setSelectedBarebone },
            { title: "Chọn Keycap", options: KEYCAPOption, selected: selectedKeycap, setSelected: setSelectedKeycap },
          ].map(({ title, options, selected, setSelected }) => (
            <div key={title}>
              <h2 className="text-xl font-medium mb-4">{title}</h2>
              <RadioGroup
                value={selected}
                onValueChange={setSelected}
                className="grid grid-cols-2 md:grid-cols-4 gap-4"
              >
                {options.map((option) => (
                  <RadioGroupItem
                    key={option.value}
                    value={option.value}
                    className="border rounded-md p-2 flex flex-col items-center text-center"
                  >
                    <img src={option.imgURL} alt={option.label} className="h-20 object-contain mb-2" />
                    <span>{option.label}</span>
                    <span className="text-sm text-muted">{option.price.toLocaleString()}đ</span>
                  </RadioGroupItem>
                ))}
              </RadioGroup>
            </div>
          ))}
        </CardContent>
      </Card>

      {/* Thanh sticky footer */}
      <div className="fixed bottom-0 left-0 right-0 bg-white shadow-lg border-t px-6 py-4 z-50 flex justify-between items-center">
        <div className="text-lg font-semibold">
          Tổng cộng: <span className="text-primary">{totalPrice.toLocaleString()}đ</span>
        </div>
        <Button className="h-10 px-6 bg-primary text-white">Thêm vào giỏ hàng</Button>
      </div>
    </div>
  );
};
