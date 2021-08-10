function hough_img = generateHoughAccumulator(img, theta_num_bins, rho_num_bins)
    count = 2 * rho_num_bins + 1; 
    hough_img = zeros(theta_num_bins, count);
    for row = 1 : size(img,1)
        for col = 1 : size(img,2)
            if img(row, col) ~= 0  
                for idx = 1 : theta_num_bins
                    theta = idx * 180 / theta_num_bins;
                    rho = col * cosd(theta) - row * sind(theta);
                    max_rho = sqrt(size(img,1)^2 + size(img,2)^2);
                    bin_idx = round(rho * rho_num_bins / max_rho + rho_num_bins);

                    if bin_idx > 0 && bin_idx <= count
                        hough_img(idx, bin_idx) = hough_img(idx, bin_idx) + 1;
                    end
                end
            end
        end
    end
    %Scale
    min_val = min(hough_img(:));
    max_val = max(hough_img(:));
    for row = 1 : theta_num_bins
        for col = 1 : count
            hough_img(row, col) = (hough_img(row, col) - min_val) / (max_val - min_val) * 255;
        end
    end

    
end






















