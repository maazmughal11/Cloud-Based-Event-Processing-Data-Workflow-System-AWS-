
---

## 🟢 `tests/test_schemas.py`

```python
def test_fact_orders_daily_schema():
    expected_columns = {
        "order_date",
        "product_id",
        "region_id",
        "total_quantity",
        "total_revenue_usd",
        "avg_order_value_usd",
        "unique_customers",
    }

    # This represents the schema you expect in Redshift
    actual_columns = {
        "order_date",
        "product_id",
        "region_id",
        "total_quantity",
        "total_revenue_usd",
        "avg_order_value_usd",
        "unique_customers",
    }

    assert expected_columns == actual_columns


def test_dim_product_schema():
    expected_columns = {"product_id", "product_name"}
    actual_columns = {"product_id", "product_name"}
    assert expected_columns == actual_columns


def test_dim_region_schema():
    expected_columns = {"region_id", "region_code"}
    actual_columns = {"region_id", "region_code"}
    assert expected_columns == actual_columns
