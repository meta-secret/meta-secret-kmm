package data
import java.util.UUID

interface CommonItemModel {
    val type: ItemType
    val id: UUID
}