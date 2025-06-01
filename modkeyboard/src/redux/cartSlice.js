import { createSlice } from "@reduxjs/toolkit";

const SESSION_KEY = "cart_items";

const loadFromSession = () => {
  const data = sessionStorage.getItem(SESSION_KEY);
  return data ? JSON.parse(data) : [];
};

const saveToSession = (cart) => {
  sessionStorage.setItem(SESSION_KEY, JSON.stringify(cart));
};

const cartSlice = createSlice({
  name: "cart",
  initialState: {
    items: loadFromSession(),
  },
  reducers: {
    addToCart: (state, action) => {
      const product = action.payload;
      const existing = state.items.find((p) => p.id === product.id);
      if (existing) {
        existing.quantity += 1;
      } else {
        state.items.push({ ...product, quantity: 1 });
      }
      saveToSession(state.items);
    },
    removeFromCart: (state, action) => {
      const newItems = state.items.filter((p) => p.id !== action.payload);
      saveToSession(newItems);
      return {
        ...state,
        items:newItems,
      };
    },
    updateQuantity: (state, action) => {
      const { id, quantity } = action.payload;
      if (quantity <= 0) {
        state.items = state.items.filter((p) => p.id !== id);
      } else {
        const product = state.items.find((p) => p.id === id);
        if (product) product.quantity = quantity;
      }
      saveToSession(state.items);
    },
    clearCart: (state) => {
      state.items = [];
      saveToSession(state.items);
    },
  },
});

export const { addToCart, removeFromCart, updateQuantity, clearCart } =
  cartSlice.actions;

export default cartSlice.reducer;
