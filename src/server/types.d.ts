interface OutfitComponent
{
    type: "item" | "prop";
    drawable: number;
    texture: number;
    componentId: number;
    title: string;
}

interface QueryRes<T>
{
    rowCount: number;
    rows: T[];
}

interface getPlayerOutfitByCidRes
{
    outfit: string;
}

interface ClothingStore 
{
    x: number;
    y: number;
    z: number;
    h: number;
    name: string;
    model: string;
}

interface Entry
{
    name: string;
    event: string;
}