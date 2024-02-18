import Vector from "./classes/Vector";
import { stores } from "./stores";

export const isInClothingStore = (pCoords: Vector): Promise<boolean> =>
{
    return new Promise((res, rej) =>
    {
        stores.forEach(store =>
        {
            if (store.coords.distanceTo(pCoords) < 1.5)
            {
                res(true);
            }
        });
        rej(`[Func isInClothingStore] - Not in any clothing store ...`);
    });
}