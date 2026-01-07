<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Media;
use App\Support\CompanyContext;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class MediaController extends Controller
{
    public function upload(Request $request)
    {
        $data = $request->validate([
            'file' => ['required', 'file', 'max:10240'],
        ]);

        $file = $data['file'];
        $path = $file->store('uploads', 'public');

        $media = Media::create([
            'company_id' => app(CompanyContext::class)->companyId(),
            'disk' => 'public',
            'path' => $path,
            'filename' => $file->getClientOriginalName(),
            'mime_type' => $file->getMimeType(),
            'size' => $file->getSize(),
        ]);

        return response()->json([
            'media' => $media,
            'url' => Storage::disk('public')->url($path),
        ], 201);
    }
}
