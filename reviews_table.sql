-- Create reviews table for Nadia Braids
CREATE TABLE IF NOT EXISTS public.reviews (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    customer_name TEXT NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    service_type TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_approved BOOLEAN DEFAULT false
);

-- Enable Row Level Security
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;

-- Policy: Anyone can read approved reviews
CREATE POLICY "Public can read approved reviews" 
ON public.reviews 
FOR SELECT 
USING (is_approved = true);

-- Policy: Admin can read all reviews
CREATE POLICY "Admin can read all reviews" 
ON public.reviews 
FOR SELECT 
TO authenticated 
USING (true);

-- Policy: Anyone can submit a review
CREATE POLICY "Anyone can submit reviews" 
ON public.reviews 
FOR INSERT 
TO anon, authenticated 
WITH CHECK (true);

-- Policy: Admin can update reviews
CREATE POLICY "Admin can update reviews" 
ON public.reviews 
FOR UPDATE 
TO authenticated 
USING (true);

-- Policy: Admin can delete reviews
CREATE POLICY "Admin can delete reviews" 
ON public.reviews 
FOR DELETE 
TO authenticated 
USING (true);

-- Create indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_reviews_approved ON public.reviews(is_approved);
CREATE INDEX IF NOT EXISTS idx_reviews_created_at ON public.reviews(created_at DESC);