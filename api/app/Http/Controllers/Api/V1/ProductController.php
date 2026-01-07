<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Support\CompanyContext;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $products = Product::orderBy('id', 'desc')->paginate(20);

        return response()->json($products);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'sku' => ['nullable', 'string', 'max:100'],
            'name' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'price' => ['nullable', 'numeric'],
            'cost' => ['nullable', 'numeric'],
            'stock' => ['nullable', 'integer'],
            'unit' => ['nullable', 'string', 'max:50'],
        ]);

        $data['company_id'] = app(CompanyContext::class)->companyId();

        $product = Product::create($data);

        return response()->json($product, 201);
    }

    public function show(Product $product)
    {
        return response()->json($product);
    }

    public function update(Request $request, Product $product)
    {
        $data = $request->validate([
            'sku' => ['nullable', 'string', 'max:100'],
            'name' => ['sometimes', 'required', 'string', 'max:255'],
            'description' => ['nullable', 'string'],
            'price' => ['nullable', 'numeric'],
            'cost' => ['nullable', 'numeric'],
            'stock' => ['nullable', 'integer'],
            'unit' => ['nullable', 'string', 'max:50'],
        ]);

        $product->update($data);

        return response()->json($product);
    }

    public function destroy(Product $product)
    {
        $product->delete();

        return response()->json(['message' => 'Product deleted.']);
    }
}
