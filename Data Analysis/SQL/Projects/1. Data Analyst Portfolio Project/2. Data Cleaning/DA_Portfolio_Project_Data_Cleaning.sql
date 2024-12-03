/*
    Cleaning Data in SQL Queries
*/

SELECT *
FROM PortfolioProject..NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------
-- Standardize Date Format

-- To get information about a specific table
exec sp_help NashvilleHousing

SELECT SaleDate, 
       CONVERT(DATE, SaleDate)
FROM PortfolioProject..NashvilleHousing


UPDATE PortfolioProject..NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)

-- It doesn't change permanently. Therefore a new column was added.
ALTER TABLE PortfolioProject..NashvilleHousing
ADD SaleDateConverted DATE 

UPDATE PortfolioProject..NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)


--------------------------------------------------------------------------------------------------------------------------
-- Populate Property Address data
-- There are some roes that have null Property Address. We are trying to fill it with values by ParcelId.

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing
Where PropertyAddress IS NULL

SELECT a.ParcelID, 
       a.PropertyAddress, 
       b.ParcelID, 
       b.PropertyAddress, 
       ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing AS a
    JOIN PortfolioProject.dbo.NashvilleHousing AS b
        ON a.ParcelID = b.ParcelID
        AND a.[UniqueID ]  <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
    JOIN PortfolioProject.dbo.NashvilleHousing b
        ON a.ParcelID = b.ParcelID
        AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


--------------------------------------------------------------------------------------------------------------------------
-- Breaking out Address into Individual Columns (Address, City, State)

SELECT PropertyAddress,
       SUBSTRING(PropertyAddress, 0, CHARINDEX(',', PropertyAddress)) AS Address,
       SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)  + 1, LEN(PropertyAddress)) AS City
FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(255),
    PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ),
    PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress));


SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

-- Another way to split by delimeter
SELECT PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3),
       PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2),
       PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255),
	OwnerSplitCity Nvarchar(255),
	OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3),
    OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2),
    OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1);



--------------------------------------------------------------------------------------------------------------------------
-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT Distinct(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY SoldAsVacant

SELECT SoldAsVacant,
       CASE 
           WHEN SoldAsVacant = 'Y' THEN 'YES'
           WHEN SoldAsVacant = 'N' THEN 'NO'
           ELSE SoldAsVacant
       END
FROM PortfolioProject.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE 
                       WHEN SoldAsVacant = 'Y' THEN 'YES'
                       WHEN SoldAsVacant = 'N' THEN 'NO'
                       ELSE SoldAsVacant
                   END


--------------------------------------------------------------------------------------------------------------------------
-- Remove Duplicates

WITH RowNumCTE AS(
	SELECT *,
	ROW_NUMBER() OVER (
		PARTITION BY ParcelID, PropertyAddress, 
					 SalePrice, SaleDate, LegalReference
					 ORDER BY UniqueID)  AS row_num
	FROM PortfolioProject.dbo.NashvilleHousing
		--order by ParcelID 
)

-- DELETE Then SELECT
SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY ParcelID


--------------------------------------------------------------------------------------------------------------------------
-- Delete Unused Columns

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate